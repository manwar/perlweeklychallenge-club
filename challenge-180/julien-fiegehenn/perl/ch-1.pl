#!perl
use strict;
use warnings;
use feature 'say';

# You are given a string, $s. Write a script to find out the first unique character in the given string and print its index (0-based).

sub first_unique_char {
    my ($s) = @_;

    my @chars = split //, $s;
    my %count;
    $count{$_}++ for @chars;
    for my $c (@chars) {
        return index $s, $c if $count{$c} == 1;
    }
}

use Test::More;

is first_unique_char('foo'), 0;
is first_unique_char('boobs'), 4;

done_testing;

say first_unique_char('foo');
say first_unique_char('boobs');
