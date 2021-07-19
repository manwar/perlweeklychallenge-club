#!/opt/local/bin/gawk

#
# See ../README.md
#

#
# Run as: gawk -f ch-1.gawk < input-file
#

{
    print xor ($1, lshift (1, $2 - 1))
}
