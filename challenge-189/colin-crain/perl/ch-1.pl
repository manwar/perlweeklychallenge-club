#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       the-bigger-man.pl
#
#       Greater Character
#         Submitted by: Mohammad S Anwar
#         You are given an array of characters (a..z) and a target
#         character.
# 
#         Write a script to find out the smallest character in the given
#         array lexicographically greater than the target character.
# 
#         Example 1
#             Input: @array = qw/e m u g/, $target = 'b'
#             Output: e
#     
#         Example 2
#             Input: @array = qw/d c e f/, $target = 'a'
#             Output: c
#     
#         Example 3
#             Input: @array = qw/j a r/, $target = 'o'
#             Output: r
#     
#         Example 4
#             Input: @array = qw/d c a f/, $target = 'a'
#             Output: c
#     
#         Example 5
#             Input: @array = qw/t g a l/, $target = 'v'
#             Output: v
#
#         method:
# 
#             First we sort the array using casefolding. This will order
#             the characters regradless to case, lexicographically.
# 
#             Then we apply a grep filter to only pass characters ordered
#             after the target.
# 
#             The first character in this list will be the smallest
#             character greater than the target, with its case preserved.
# 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub next_larger_char ( $arr, $target ) {
    my $target_fc = fc($target);
    my @out = map  { $_->[0] }
              grep { $_->[1] gt $target_fc }
              sort { $a->[1] cmp $b->[1] }
              map  { [$_, fc($_)] } 
              $arr->@*;
    return $out[0]
        ? $out[0]
        : $target ;
}




use Test::More;

is next_larger_char( [ qw/e m u g/ ], 'b' ), 'e', 'ex-1';
is next_larger_char( [ qw/d c e f/ ], 'a' ), 'c', 'ex-2';
is next_larger_char( [ qw/j a r/   ], 'o' ), 'r', 'ex-3';
is next_larger_char( [ qw/d c a f/ ], 'a' ), 'c', 'ex-4';
is next_larger_char( [ qw/t g a l/ ], 'v' ), 'v', 'ex-5';

done_testing();

