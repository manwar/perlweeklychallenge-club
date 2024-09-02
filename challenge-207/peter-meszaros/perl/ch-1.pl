#!/usr/bin/env perl
#
=head1 Task 1: Keyboard Word

Submitted by: Mohammad S Anwar

You are given an array of words.

Write a script to print all the words in the given array that can be types
using alphabet on only one row of the keyboard.

Let us assume the keys are arranged as below:

	Row 1: qwertyuiop
	Row 2: asdfghjkl
	Row 3: zxcvbnm

=head2 Example 1

	Input: @words = ("Hello","Alaska","Dad","Peace")
	Output: ("Alaska","Dad")

=head2 Example 2

	Input: @array = ("OMG","Bye")
	Output: ()

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/all/;

my $cases = [
	[["Hello","Alaska","Dad","Peace"], ["Alaska","Dad"], 'Example 1'],
    [["OMG","Bye"],                                  [], 'Example 2'],
];

my $kbds = [
    {map {$_ => 1} qw/q w e r t y u i o p/},
    {map {$_ => 1} qw/a s d f g h j k l/},
    {map {$_ => 1} qw/z x c v b n m/},
];

sub keyboard_word
{
	my $l = shift;

	my @res;
    for my $w (@$l) {
		my @w = map { lc } split //, $w;
		for my $kbd (@$kbds) {
            if (all { defined } $kbd->@{@w}) {
                push @res, $w;
                last;
            }
		}
	}
	return \@res;
}

for (@$cases) {
    is(keyboard_word($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
