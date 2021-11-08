#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       get-oddly-even.pl
#
#       Swap Odd/Even bits
#         Submitted by: Mohammad S Anwar 
#         You are given a positive integer $N less than or equal to 255.
# 
#         Write a script to swap the odd positioned bit with even positioned bit
#         and print the decimal equivalent of the new binary representation.
# 
#             Example 
# 
#             Input : $N = 101 
#             Output: 154
# 
#                 Binary representation of the given number is 01 10 01 01. The
#                 new binary representation after the odd/even swap is 10 01 10
#                 10. The decimal equivalent of 10011010 is 154.
# 
#             Input : $N = 18 
#             Output: 33
# 
#                 Binary representation of the given number is 00 01 00 10. The
#                 new binary representation after the odd/even swap is 00 10 00
#                 01. The decimal equivalent of 100001 is 33.
# 
#           
#         method
#             we know the number is less than 256 and greater than 0, so it will
#             fit cleanly into an 8-bit binary representation. The first order
#             of action is to convert it into this set number of 0 and 1 digits,
#             signifying bits, using the "%08b" format specifier. Now the fun
#             begins.
# 
#             We know the length of the string to be 8 characters exactly. By
#             applying a global regular expression match against pairings of 1s
#             and 0s we can divide our 8 characters into 4 groups of 2, returned
#             as a list. In this list we use `reverse` in a scalar context to
#             map each string to a reversed version of itself, swapping the
#             characters. These mutated string bits are then rejoined with a
#             "0b" prefix to indicate to `oct` that we wish to parse a string as
#             though it were a binary number. This returns our altered bit
#             string to the decimal number requested for output. 
# 
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $num = shift // 18;

my $bin = sprintf "%08b", $num;
my $res = oct(join '', '0b', map { scalar reverse "$_" } $bin =~ /([01]{2})/g );

say<<"END";
input:  $num
output: $res

END
