#!/usr/bin/perl
use warnings;
use strict;

sub reverse_words {
    my ($string) = @_;
    join ' ', reverse split ' ', $string
}

use Test::More tests => 3;

is reverse_words('Single'), 'Single', 'Single word';
is reverse_words('The Weekly Challenge'), 'Challenge Weekly The', 'Example 1';
is reverse_words('    Perl and   Raku are  part of the same family  '),
    'family same the of part are Raku and Perl', 'Example 2';
