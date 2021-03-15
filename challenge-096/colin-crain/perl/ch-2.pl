#! /opt/local/bin/perl
#
#       Wagner–Fischer-Price.pl
#
#         TASK #2 › Edit Distance
#         Submitted by: Mohammad S Anwar
#         You are given two strings $S1 and $S2.
# 
#         Write a script to find out the minimum operations required to convert
#         $S1 into $S2. The operations can be insert, remove or replace a
#         character. Please check out Wikipedia page for more information.
#             https://en.wikipedia.org/wiki/Edit_distance
# 
#         Example 1:
#             Input: $S1 = "kitten"; $S2 = "sitting"
#             Output: 3
# 
#                 Operation 1: replace 'k' with 's'
#                 Operation 2: replace 'e' with 'i'
#                 Operation 3: insert 'g' at the end
#                 
#         Example 2:
#             Input: $S1 = "sunday"; $S2 = "monday"
#             Output: 2
# 
#                 Operation 1: replace 's' with 'm'
#                 Operation 2: replace 'u' with 'o'
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use List::Util qw( min );

sub levenshtein {
    my ($s, $t) = @_;
    my ($m, $n) = map { length($_) } ($s, $t);
    my @mat;
    
    $mat[$_][0] = $_ for ( 0..$m);
    $mat[0]     = [ 0..$n ];

    for my $j ( 1..$n ) {
        for my $i ( 1..$m ) {
            my $cost = (substr($s,$i-1,1) eq substr($t,$j-1,1) ?  0 : 1);
            $mat[$i][$j] = min( $mat[$i-1][$j] + 1,
                                $mat[$i][$j-1] + 1,
                                $mat[$i-1][$j-1] + $cost );
        }
    }
        
    return $mat[$m][$n];
}


use Test::More;

is (levenshtein('kitten','sitting'), 3, 'ex 1');
is (levenshtein('sunday','monday'), 2, 'ex 2');
is (levenshtein('Sunday','Saturday'), 3, 'wiki');


done_testing();


