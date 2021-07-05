#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    print (        ($1 - ($1 % 256)) \
            +      ($1 %  16) * 16   \
            + int (($1 % 256) / 16))
}
