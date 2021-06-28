#!/usr/bin/env raku

use Test;
plan 2;

is binary-palindrome(5), 1;
is binary-palindrome(4), 0;

sub binary-palindrome(UInt $N where * > 0)
{
    my $b = $N.base(2);
    +($b eq $b.flip);
}
