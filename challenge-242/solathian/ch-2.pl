#!usr/bin/perl
use v5.38;
use Data::Dumper;
# Challenge 242 - 2 - Flip Matrix


flip( [[1, 1, 0], [1, 0, 1], [0, 0, 0]]);                         # ([1, 0, 0], [0, 1, 0], [1, 1, 1])
flip( [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]);  #([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

sub flip($listRef)
{
    foreach my $rowRef (@$listRef)
    {
        @$rowRef = map{($_ == 0) ? 1 : 0 } reverse @$rowRef;
    }
    
    say Dumper $listRef;
}