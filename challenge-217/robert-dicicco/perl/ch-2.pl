#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Algorithm::Permute;
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Max Number ( Perl )
---------------------------------------
=cut

my @list = ([5,11,4,1,2],[31, 2, 4,10],[10,3,2],[1, 23],[1,10]);
my $max = 0;

for my $lst (@list) {
    print("Input: \@list = [@$lst]\n");
    my $p_iterator = Algorithm::Permute->new ( $lst );
    while (my @perm = $p_iterator->next) {
        my $num = join("",@perm);
        if ($num > $max) {
            $max = $num;
        }
    }
    print("Output: $max\n\n");
    $max = 0;
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
perl MaxNumber.pl
Input: @list = [5 11 4 1 2]
Output: 542111

Input: @list = [31 2 4 10]
Output: 431210

Input: @list = [10 3 2]
Output: 3210

Input: @list = [1 23]
Output: 231

Input: @list = [1 10]
Output: 110
---------------------------------------
=cut


