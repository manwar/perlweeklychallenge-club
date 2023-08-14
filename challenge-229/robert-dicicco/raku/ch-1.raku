#!/usr/bin/env raku
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-07
Challenge 229 Lexical Order Task 1 ( Raku )
---------------------------------------
=end comment
use  v6;

my @strs = (["abc", "bce", "cae"],["yxz", "cba", "mon"]);

my $cnt = 0;

sub CheckLexOrder($e) {
    my $lexstr = $e.comb.sort.join;
    ($e eq $lexstr) || ($e eq $lexstr.flip)  ?? (1) !! (0);
}

for (@strs) -> @str {
    say "Input: \@str = ",@str;
    for ( @str) -> $elm {
        my $retval = CheckLexOrder($elm);
        $cnt++ if ($retval == 0);
    }
    say "Output: $cnt\n";
    $cnt = 0;
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
raku .\LexOrder.rk

Input: @str = [abc bce cae]
Output: 1

Input: @str = [yxz cba mon]
Output: 2
---------------------------------------
=end comment


