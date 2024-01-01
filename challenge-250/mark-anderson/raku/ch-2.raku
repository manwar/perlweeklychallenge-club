#!/usr/bin/env raku
use Test;

is alphanumeric-string-value(<perl 2 000 python r4ku>), 6;
is alphanumeric-string-value(<001 1 000 0001>),         1;

sub alphanumeric-string-value(@a)
{
    max map { .parse-base(10) // .chars }, @a
}
