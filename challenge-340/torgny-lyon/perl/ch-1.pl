#!/usr/bin/perl

use v5.42;

use Test::More tests => 5;

sub remove_duplicates {
    my $s = shift;
    while ($s =~ s/(.)\1//g) {}
    $s;
}

is(remove_duplicates('abbaca'),   'ca');
is(remove_duplicates('azxxzy'),   'ay');
is(remove_duplicates('aaaaaaaa'), q{});
is(remove_duplicates('aabccba'),  'a');
is(remove_duplicates('abcddcba'), q{});
