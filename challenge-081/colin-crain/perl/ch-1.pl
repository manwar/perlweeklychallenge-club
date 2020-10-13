#! /opt/local/bin/perl
#
#       common_bonds.pl
#         TASK #1 › Common Base String
#         Submitted by: Mohammad S Anwar
#         You are given 2 strings, $A and $B.
# 
#         Write a script to find out common base strings in $A and $B.
# 
#         A substring of a string $S is called base string if 
#         repeated concatenation of the substring results in the string.
# 
#         Example 1:
#         Input:
#             $A = "abcdabcd"
#             $B = "abcdabcdabcdabcd"
# 
#         Output:
#             ("abcd", "abcdabcd")
#         Example 2:
#         Input:
#             $A = "aaa"
#             $B = "aa"
# 
#         Output:
#             ("a")
# 
#         method:
#             This really isn't as complicated as it may sound.
# 
#             A common base string must by definition be sized as a harmonic
#             divisor of the original: 1/2, 1/3, 1/4 etc. We can save some
#             trouble by looking at only those substrings that fit this basic
#             constraint.
# 
#             Any base string will begin the source string and extend for n
#             characters, with n contained within the set of fractional
#             components outlined above with respect to the source string
#             length. Thus 1/2 length, or 1/3, 1/4 etc.
#             
#             It's also rather difficult to come up with a good example as most
#             input variations produce super-obvious results. Not much of a
#             needle in a haystack going on here.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

@ARGV == 0 and @ARGV = qw(agtcagtcagtcagtc agtcagtcagtcagtcagtcagtcagtcagtc);

my ($A, $B) = @ARGV;
my @out;
my %subs_a = map {$_ => 1} find_base_strings($A);
for (find_base_strings($B)) {
    push @out, $_ if exists $subs_a{$_} ;
}
say $_ for @out;


## ## ## ## ## SUBS:

sub find_base_strings {
    my $str = shift;
    my $len = length $str;
    my @out;
    
    for (1..$len) {
        next unless $len % $_ == 0;
        my $sub = substr $str, 0, $len/$_;
        my $res = $str =~ /^(?:$sub)+$/;
        push @out, $sub if $res;
    }
    return @out;
}