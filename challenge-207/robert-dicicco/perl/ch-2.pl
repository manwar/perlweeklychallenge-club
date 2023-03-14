#!/usr/bin/env perl
=begin comment
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-07
Challenge 207 H-Index ( Perl )
==================================
=cut
use strict;
use warnings;
use feature "say";

my @citations = ([10,8,5,4,3],[25,8,5,3,3]);

sub CalcIndex {
    my $arr = shift;
    my $ln = scalar(@$arr);
    my $offset = $ln;
    $offset = $ln-1;
    my $pos = $ln;
    while($offset >= 0) {
        if(@$arr[$offset] >= $pos){
            say "Output: $pos\n";
            return;
        } else {
            $offset--;
            $pos--;
        }
    }
}

for my $c (@citations) {
    say "Input: \@citations = [@$c]";
    CalcIndex($c);
}

=begin comment
==================================
SAMPLE OUTPUT
perl .\HIndex.pl
Input: @citations = [10 8 5 4 3]
Output: 4

Input: @citations = [25 8 5 3 3]
Output: 3
==================================
=cut
