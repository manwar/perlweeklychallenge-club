#!/bin/bash

# usage: ch-1.sh [N]
# call ch-1.pl N times (default: 80), count the individual printed words
# and sort by frequency

for i in $(seq 1 ${1:-80}); do ./ch-1.pl; done | sort | uniq -c | sort -n
