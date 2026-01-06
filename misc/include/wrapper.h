#ifndef COPY_FILE_RANGE_H
#define COPY_FILE_RANGE_H

#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

typedef off_t loff_t;

static inline ssize_t copy_file_range(int fd_in, loff_t *off_in, int fd_out, loff_t *off_out, size_t len, unsigned int flags)
{
	if (flags) {
		errno = EINVAL;
		return -1;
	}
	off_t pos_in = off_in ? lseek(fd_in, *off_in, SEEK_SET) : lseek(fd_in, 0, SEEK_CUR);
	off_t pos_out = off_out ? lseek(fd_out, *off_out, SEEK_SET) : lseek(fd_out, 0, SEEK_CUR);
	if (pos_in < 0 || pos_out < 0) return -1;
	ssize_t copied = 0;
	char buf[8192];
	while (len > 0) {
		size_t chunk = len < sizeof(buf) ? len : sizeof(buf);
		ssize_t rd = read(fd_in, buf, chunk);
		if (rd <= 0) break;
		ssize_t wr = write(fd_out, buf, rd);
		if (wr != rd) { copied = -1; break; }
		copied += wr; len -= wr;
	}
	if (off_in) *off_in += copied > 0 ? copied : 0;
	if (off_out) *off_out += copied > 0 ? copied : 0;
	return copied > 0 ? copied : (copied < 0 ? -1 : 0);
}

#endif
