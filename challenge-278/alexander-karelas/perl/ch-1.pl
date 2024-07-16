#!/usr/bin/env perl

use v5.40;

use Test::More;

sub do_it ($str) {
    my @words = $str =~ /(\w+)/g;
    @words = map [chop, $_], @words;
    @words = sort { $a->[0] <=> $b->[0] } @words;
    @words = map $_->[1], @words;
    return "@words";
}

is do_it('and2 Raku3 cousins5 Perl1 are4'), 'Perl and Raku are cousins', 'Example 1';
is do_it('guest6 Python1 most4 the3 popular5 is2 language7'), 'Python is the most popular guest language', 'Example 2';
is do_it('Challenge3 The1 Weekly2'), 'The Weekly Challenge', 'Example 3';

done_testing();