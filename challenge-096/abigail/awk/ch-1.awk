#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

#
# AWK splits lines on whitespace, making each field available
# in $1, $2, ..., etc. So, we just print the fields in reverse,
# followed by a space (or a newline after the last/first).
#
{
    for (i = NF; i; i --) {
        printf "%s%s", $i, (i == 1 ? "\n" : " ");
    }
}
