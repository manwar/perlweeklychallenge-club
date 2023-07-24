#!/usr/bin/env raku
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-17
Challenge 226 Task 1 Shuffle String ( Raku )
--------------------------------------
=end comment
use v6;

my @strings = ('lacelengh', 'rulepark');
my @indices = ([3,2,0,5,4,8,6,7,1],[4,7,3,1,0,5,2,6]);

my $offset = 0;
my %letters = ();
my $letter;

for ( @strings) -> $str {
    my $ndx = @indices[$offset];
    print("Input: \$string = $str, \@indices = ($ndx)\n");
    my $cnt = 0;
    while $cnt < $str.chars {
        $letter = substr($str,$cnt,1);
        %letters{$ndx[$cnt++]} = $letter;
    }
    $cnt = 0;
    print("Output: ");
    while $cnt < $str.chars {
        print(%letters{$cnt++});
    }
    print("\n\n");
    ($offset == @indices.elems) ?? (exit) !! ($offset++);
}

=begin comment
--------------------------------------
SAMPLE OUTPUT
raku ShuffleString.rk

Input: $string = lacelengh, @indices = (3 2 0 5 4 8 6 7 1)
Output: challenge

Input: $string = rulepark, @indices = (4 7 3 1 0 5 2 6)
Output: perlraku
--------------------------------------
=end comment


