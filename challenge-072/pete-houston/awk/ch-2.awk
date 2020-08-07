#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 7202.awk
#        USAGE: 7202.awk X Y filename [ filename ... ]
#
#  DESCRIPTION: Only print the lines of the supplied file(s) between
#               line numbers X and Y inclusive.
#
#        NOTES: Arguments X and Y are whole numbers. Y >= X, X >= 1.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/08/20
#===============================================================================
BEGIN { start = ARGV[1]; finish = ARGV[2]; delete ARGV[2]; delete ARGV[1]; }
FNR > finish { nextfile; }
FNR >= start
