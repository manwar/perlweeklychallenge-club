#!/usr/bin/env perl
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-18
Challenge 235 Task 1 Remove One ( Perl )
---------------------------------------
=cut

use v5.38;

my @myints = ([0, 2, 9, 4, 6],[5, 1, 3, 2],[2, 2, 3]);

for my $mints (@myints) {
    say "Input: \@ints = [@$mints]";
    my $len = scalar @$mints;
    my $cnt = 0;
    my $x = 1;
    while($x < $len) {
        if (@$mints[$x] > @$mints[$x - 1]) {
            say "\t@$mints[$x] greater than @$mints[$x - 1]";
            $x++;
        } else {
            say "\t@$mints[$x] less than @$mints[$x - 1]";
            $cnt++;
            $x++;
        }
    }
    $cnt == 1 ? say "Output: true\n" : say "Output: false\n";
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
perl .\RemoveOne.pl

Input: @ints = [0 2 9 4 6]
        2 greater than 0
        9 greater than 2
        4 less than 9
        6 greater than 4
Output: true

Input: @ints = [5 1 3 2]
        1 less than 5
        3 greater than 1
        2 less than 3
Output: false

Input: @ints = [2 2 3]
        2 less than 2
        3 greater than 2
Output: true
---------------------------------------
=cut


