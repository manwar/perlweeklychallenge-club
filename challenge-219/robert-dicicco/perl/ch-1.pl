#!usr/bin/env perl
use strict;
use warnings;
use feature 'say';
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-29
Challenge 219 Sorted Squares Task 1 ( Perl )
--------------------------------------
=cut

my @list = ([-2, -1, 0, 3, 4],
            [5, -4, -1, 3, 6]
            );
my $cnt = (scalar @list) ;

while ($cnt--) {
    say "Input: \@list = [@{$list[$cnt]}]";
    my @squared_array = map { $_ ** 2 } @{$list[$cnt]};
    my @sorted = sort { $a <=> $b } @squared_array;
    print "Output: ",join(", ", @sorted), "\n\n";
}

=begin comment
--------------------------------------
SAMPLE OUTPUT

perl .\SortedSquares.pl
Input: @list = [5 -4 -1 3 6]
Output: 1, 9, 16, 25, 36

Input: @list = [-2 -1 0 3 4]
Output: 0, 1, 4, 9, 16
--------------------------------------
=cut


