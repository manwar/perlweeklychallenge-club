#!/usr/bin/env raku

use Test;
plan 2;

my $dps1 = '""[]()';
my $str1 = '"I like (parens) and the Apple ][+" they said.';

my $dps2 = '**//<>';
my $str2 = '/* This is a comment (in some languages) */ <could be a tag>';

is find-pairs($dps1, $str1), '"(["' ~ "\n" ~ '")]"';
is find-pairs($dps2, $str2), '/**/<' ~ "\n" ~ '/**/>';

sub find-pairs($delimiters, $string)
{
    my @openers;
    my @closers;

    for $delimiters.comb -> $a, $b
    {
        @openers.push: $a;
        @closers.push: $b;
    }

    @openers = $string ~~ m:g/@openers/; 
    @closers = $string ~~ m:g/@closers/;

    "{@openers.join}\n{@closers.join}"
}
