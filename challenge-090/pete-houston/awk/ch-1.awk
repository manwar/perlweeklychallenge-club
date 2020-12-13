#!/usr/bin/gawk -f
#===============================================================================
#
#         FILE: 9001.awk
#
#        USAGE: echo STRING | ./ch-1.awk
#
#  DESCRIPTION: DNA nucleobase counts and complementary sequence
#
#        NOTES: STRING must contain uppercase A, C, G and T characters
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/12/20
#===============================================================================
BEGIN { split ("ACGT", n, //); }
{
    print "Original sequence is " $0;
    for (i in n) {
    	count = gsub (n[i], i);
    	print "Count of " n[i] " is " count;
    }
    for (i in n) {
    	gsub (i, n[5-i]);
    }
    print "Complementary sequence is " $0;
}
