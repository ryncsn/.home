function avgs
    awk '{ sum += $1; sump += ( $1 ^ 2 ) } END { avg = sum / NR; printf "Sum: %f, Avg: %f, Standard Deviation: %f, Samples: %d\n", sump, avg, sqrt( sump / NR - avg ^ 2), NR }'
end
