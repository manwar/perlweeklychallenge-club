#!/usr/bin/env perl

use Modern::Perl '2018';

my @numbers = (0 .. 25);

my @letters = ('a' .. 'z');

my %number;

@number{@letters} = @numbers;

say "array: ", join ", ", @letters[0, 4, 7];

say "hash:  ", join ", ", @number{'a', 'e', 'h'};
