#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 12201.awk
#
#        USAGE: ./12201.awk < INFILE
#
#  DESCRIPTION: Stream average - output the average of all numbers so
#               far as a list.
#
#        NOTES: Expects each number as the first field on the line
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/07/21
#===============================================================================
{ sum += $1; num++; print sum / num }
