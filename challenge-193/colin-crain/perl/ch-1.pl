#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       binstr.pl
# 
#       "like napster with binary strings. Or tumblr... with binary strings"
#
#       Binary String
#         Submitted by: Mohammad S Anwar
#         You are given an integer, $n > 0.
# 
#         Write a script to find all possible binary numbers of size $n.
# 
#         Example 1
#             Input: $n = 2
#             Output: 00, 11, 01, 10
# 
#         Example 2
#             Input: $n = 3
#             Output: 000, 001, 010, 100, 111, 110, 101, 011
# 
#         method:
# 
#             Three ways of going about this come immediately to mind:
# 
#             1. we could generate fixed-digit binary representations of
#             all numbers within a given range, defined by powers of two.
#             This is mathematically elegant by nature, and can be
#             performed simply using the format "%0${n}b" with sprintf.
# 
#             2. we could, starting with a null string, create a
#             bifrucating tree of possibilities by affixing both possible
#             characters 0 and 1 to each existing sting in the set until
#             the correct length is achieve. This is elegantly wise in
#             string use, as it creates the correct respones with no
#             knowledge of either binary numbers or mathematics at all.
# 
#             3. perhaps one of the most perlish ways to do this would be
#             to use wildcard filename expansion using glob. This is
#             elegantly perlish
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';





my $n = shift @ARGV // 5;

## THREE TECHNIQUES

## 1. using math to find all numbers up to a string of 1s of length $n
##    - this upper limit is is 2^n-1
##    - zero padding on the left means the lower limit is simply 0
say sprintf "%0${n}b", $_ for (0..2**$n-1);



say '';

## 2. constructing a tree of strings one digit at a time
##    - each string position can ba a 1 or a 0, so for every existing
##      string make 2 new ones appending one of these two options,
##      repeat until enough positions are generated (strings are long enough)
say for bindigit( $n );

sub bindigit ( $target ) {
    my @arr = ( 0, 1 );
    @arr = map { $_ . 0, $_ . 1 } @arr for ( 1..$n-1 );
    return @arr;
}



say '';

## 3. using a hack of filename expansion
##    - dark perl magic
say for glob '{0,1}' x $n;

