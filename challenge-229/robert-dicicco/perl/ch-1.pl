#!/usr/bin/env perl
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-07
Challenge 229 Lexical Order Task 1 ( Perl )
---------------------------------------
=cut

use v5.38;

my @strs = (["abc", "bce", "cae"],["yxz", "cba", "mon"]);

my $cnt = 0;

sub CheckLexOrder($e) {
    my $lexstr = join("",sort(split("",$e)));
    ($e eq $lexstr) or ($e eq reverse($lexstr)) ? return 1 : return 0;
}

for my $str (@strs) {
    say "Input: \@str = (@$str)";
    for my $elm ( @$str) {
        my $retval = CheckLexOrder($elm);
        $cnt++ if ($retval == 0);
    }
    say "Output: $cnt\n";
    $cnt = 0;
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
perl .\LexOrder.pl

Input: @str = (abc bce cae)
Output: 1

Input: @str = (yxz cba mon)
Output: 2
---------------------------------------
=cut


