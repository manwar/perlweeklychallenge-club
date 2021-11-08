#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 12101.awk
#
#        USAGE: ./12101.awk
#
#  DESCRIPTION: Invert the Nth least significant bit of number M and output.
#
# REQUIREMENTS: Tested with gawk 4.1.1
#        NOTES: Input M and N on one line of STDIN
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/07/21
#===============================================================================
$1 == int ($1) && $2 == int ($2) { print xor ($1, 2 ** ($2 - 1)) }
