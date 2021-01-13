#! /opt/local/bin/perl
#
#       one-zero-zero-one.pl
#
#         TASK #2 › 0/1 String
#         Submitted by: Mohammad S Anwar
#             A 0/1 string is a string in which every character is
#             either 0 or 1.
#
#             Write a script to perform switch and reverse to generate
#             S30 as described below:
#
#             switch:
#
#                 Every 0 becomes 1 and every 1 becomes 0. For example,
#                 “101” becomes “010”.
#
#             reverse:
#
#                 The string is reversed. For example, "001” becomes
#                 “100”.
#
#             Please follow the rule as below:
#
#                 S0 = “”
#                 S1 = “0”
#                 S2 = “001”
#                 S3 = “0010011”
#                 …
#                 SN = SN-1 + “0” + switch(reverse(SN-1))
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $num = $ARGV[0] // 7;
say S($num);

## ## ## ## ## SUBS:

sub S {
    my $n = shift;
    return '' if $n == 0;
    my $str = S ($n-1);
    return $str . '0' . reverse( $str =~ tr/01/10/r );
}
