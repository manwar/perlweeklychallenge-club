#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub string_format($str, $i) {
    $str =~ tr/-//d;
    my $mod = length($str) % $i;
    $str =~ s/(?<=^.{$mod})/-/ if $mod && $mod != length $str;

    $str =~ /-/g;                            # Set pos to the dash (if any).
    return $str =~ s/\G(.{$i})(?=.)/$1-/rg;  # Separate groups of size $i.
}

use Test::More tests => 3 + 2;

is string_format('ABC-D-E-F', 3), 'ABC-DEF', 'Example 1';
is string_format('A-BC-D-E', 2), 'A-BC-DE', 'Example 2';
is string_format('-A-B-CD-E', 4), 'A-BCDE', 'Example 3';

is string_format('A-B', 15), 'AB', 'Single group';
is string_format("", 2), "", 'Empty string';
