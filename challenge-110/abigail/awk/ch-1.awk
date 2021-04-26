#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

                                        {line = $0;
                                         gsub (/ */, "", line)}  # Remove spaces

match (line, /^[0-9]{14}$/)   ||                   # nnnn nnnnnnnnnn
match (line, /^\+[0-9]{12}$/) ||                   # +nn  nnnnnnnnnn
match (line, /^\([0-9]{2}\)[0-9]{10}$/) {print}    # (nn) nnnnnnnnnn
