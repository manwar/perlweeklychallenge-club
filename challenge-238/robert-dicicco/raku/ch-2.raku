#!/usr/bin/env raku
=begin comment
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-12
Challenge 238 Task 02 Persistence Sort ( Raku )
----------------------------------------
=end comment

my @myints = ([15, 99, 1, 34],[50, 25, 33, 22]);

sub Reduce ( $num is copy) {
    if $num < 0 or $num > 99 {return 0;}
    my $steps = 0;
    while $num > 9 {
        $num = (floor($num/10)) * ($num % 10);
        $steps++;
    }
    return $steps;
}

for (@myints) -> @mints {
    my $cnt = 0;
    my %h;
    say "Input: @int = ["~@mints~"]";
    while $cnt < @mints.elems {
        my $retval = Reduce(@mints[$cnt]);
        %h{@mints[$cnt]} = $retval;
        $cnt++;
    }
    print "Output: [ ";
    for %h.sort: *.invert {
        print .key ~ " ";
    }
    say "]\n";
}

=begin comment
----------------------------------------
SAMPLE OUTPUT
raku .\Persistence.rk

Input: @int = [15 99 1 34]
Output: [ 1 15 34 99 ]

Input: @int = [50 25 33 22]
Output: [ 22 33 50 25 ]
----------------------------------------
=end comment

