#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    line = $0;
    gsub (/ */, "", line)                 # Remove spaces
    sub (/^\+/, "00", line)               # Replace leading + with 00
    sub (/^\([0-9]{2}\)/, "0000", line)   # Replace leading (NN) with 0000
}

match (line, /^[0-9]{14}$/) {             # Match exactly 14 digits
    print
}
