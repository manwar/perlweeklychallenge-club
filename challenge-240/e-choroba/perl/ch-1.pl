#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub acronym($chk, @str) {
    $chk eq lc join "", map substr($_, 0, 1), @str
}

use Test::More tests => 3;

ok acronym("ppp", "Perl", "Python", "Pascal"), 'Example 1';
ok ! acronym("rp", "Perl", "Raku"), 'Example 2';
ok acronym("oac", "Oracle", "Awk", "C"), 'Example 3';
