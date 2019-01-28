#!/usr/bin/env python
import sys
import base64
import weakref

from os.path import expanduser

downloaded_file = "{}/Downloads/original_msg.txt".format(expanduser("~"))
if sys.argv:
    if len(sys.argv) > 1:
        downloaded_file = sys.argv[1]

downloaded = open(downloaded_file)

headers = {}
raw_content = ""
download_content = downloaded.readlines()

header_name, header_value = None, None

def merge_newline(text):
    return "".join(text.splitlines())

def fix_newline(text):
    return "\n".join(text.splitlines())

def save_header():
    global headers
    global header_name
    global header_value

    header_value = merge_newline(header_value)
    headers[header_name] = header_value
    header_name, header_value = None, None

for line in download_content:
    if header_value and line.startswith(tuple(" \t")):
        header_value += line.lstrip(" \t")
    elif ":" in line:
        if header_name:
            save_header()
        header_name, header_value = line.split(":", 1)
    else:
        if header_name:
            save_header()
        raw_content += line

headers.pop("Content-Transfer-Encoding", "base64")
headers.pop("Content-Type", 'text/plain; charset="utf-8"')

for name, value in headers.items():
    print("{}:{}".format(name, value))

print("")
print(fix_newline(base64.b64decode(raw_content)))
