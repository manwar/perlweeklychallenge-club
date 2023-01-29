#!/usr/bin/env raku

#`{

AUTHOR: Robert DiCicco

DATE:   2023-01-23

Challenge 201 Missing Numbers ( Raku )

}

use v6;



my @arrs = [[0,1,3],[0,1]];



for (@arrs) -> @arr {

    my $len = @arr.elems;

    print("Input: \@array = [",@arr,"]\n");

    my %hash = map {$_ => 1}, @arr;

    for (0..$len) -> $x {

        say "Output: $x\n" if ! %hash{$x};

    }

}



#`{

SAMPLE OUTPUT

raku .\MissingNumbers.rk

Input: @array = [0 1 3]

Output: 2



Input: @array = [0 1]

Output: 2

}
