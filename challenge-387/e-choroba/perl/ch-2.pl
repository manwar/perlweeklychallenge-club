#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub atoms_count($formula) {
    while ($formula =~ s/\(([^()]+)\)([0-9]+)/\x01/) {
        my ($inner, $count) = ($1, $2);
        my $multiplied = "";
        while ($inner =~ s/([[:upper:]][[:lower:]]?)([0-9]*)//) {
            my ($element, $num) = ($1, $2 || 1);
            $multiplied .= $element . ($num * $count);
        }
        $formula =~ s/\x01/$multiplied/;
    }
    my %elements;
    $elements{$1} += $2 || 1
        while $formula =~ /([[:upper:]][[:lower:]]?)([0-9]*)/g;
    return join "", map $_ . (1 == $elements{$_} ? "" : $elements{$_}),
                    sort keys %elements
}

use Test::More tests => 5;

is atoms_count('((N2O)3(H2O)2)2'), 'H8N12O10', 'Example 1';
is atoms_count('Mg3(PO4)2'), 'Mg3O8P2', 'Example 2';
is atoms_count('(((H)2)3)4'), 'H24', 'Example 3';
is atoms_count('NaCl3(O2(S10)2)2Mg'), 'Cl3MgNaO4S40', 'Example 4';
is atoms_count('Z2Y3(X2W)2'), 'W2X4Y3Z2', 'Example 5';
