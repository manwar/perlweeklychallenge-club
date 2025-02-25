=begin
You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other domino.

$dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).

Example 1
Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]
Example 2
Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]
=cut

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 2;

my @tests = ([([1, 3], [3, 1], [2, 4], [6, 8])],[([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])]);

foreach(@tests){
    my @input = @$_;
    my $dominoes = findSimilarDominoes(\@input);
    print "$dominoes\n";
}

sub findSimilarDominoes {
    my $arr = shift;
    my @A = @$arr;
    my $similar = 1;

    my %set;
    
    foreach(@A){
        my $sum = 0;
        foreach (@$_){$sum += $_};
        if(exists($set{$sum})){
            $similar += 1;
        }else{
            $set{$sum} = 1;
        }
    }
    
    return $similar;
}

my @example1 = ([1, 3], [3, 1], [2, 4], [6, 8]);
my @example2 = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]);

is(findSimilarDominoes(\@example1), 2);
is(findSimilarDominoes(\@example2), 3);