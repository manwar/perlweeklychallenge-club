#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function dist (x1, y1, x2, y2) {(x1 - x2) ^ 2 + (y1 - y2) ^ 2}

{
    print (dist ($1, $2, $3, $4) == dist ($3, $4, $5, $6) &&
           dist ($3, $4, $5, $6) == dist ($5, $6, $7, $8) &&
           dist ($5, $6, $7, $8) == dist ($7, $8, $1, $2) &&
           dist ($1, $2, $5, $6) == dist ($3, $4, $7, $8) ? 1 : 0)
}
