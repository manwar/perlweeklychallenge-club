#!/usr/bin/env perl
#
=head1 Task 1: Uncommon Words

Submitted by: Mohammad Sajid Anwar

You are given two sentences.  Write a script to return list of all uncommon
words, order is not important.

=head2 Example 1

    Input: $sentence1 = "apple banana apple"
           $sentence2 = "banana orange"
    Output: ("orange")

=head2 Example 2

    Input: $sentence1 = "cat dog"
           $sentence2 = "bird fish"
    Output: ("cat", "dog", "bird", "fish")

=head2 Example 3

    Input: $sentence1 = "the quick brown fox"
           $sentence2 = "the quick"
    Output: ("brown", "fox")

=head2 Example 4

    Input: $sentence1 = "hello"
           $sentence2 = "hello"
    Output: ()

=head2 Example 5

    Input: $sentence1 = "blue blue red"
           $sentence2 = "red green green yellow"
    Output: ("yellow")

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {sentence1 => "apple banana apple",
     sentence2 => "banana orange",          out => ["orange"],                     name => 'Example 1'},
    {sentence1 => "cat dog",
     sentence2 => "bird fish",              out => ["bird", "cat", "dog", "fish"], name => 'Example 2'},
    {sentence1 => "the quick brown fox",
     sentence2 => "the quick",              out => ["brown", "fox"],               name => 'Example 3'},
    {sentence1 => "hello",
     sentence2 => "hello",                  out => [],                             name => 'Example 4'},
    {sentence1 => "blue blue red",
     sentence2 => "red green green yellow", out => ["yellow"],                     name => 'Example 5'},
);

sub uncommon_words
{
    my $sentence1 = shift;
    my $sentence2 = shift;
    my %count;
    $count{$_}++ for split /\s+/, $sentence1;
    $count{$_}++ for split /\s+/, $sentence2;
    return [grep { $count{$_} == 1 } keys %count];
}

for my $case (@cases) {
    my $got = uncommon_words($case->{sentence1}, $case->{sentence2});
    $got = [sort @$got];
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
