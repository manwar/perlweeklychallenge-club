#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Roman;

my @examples = (
    "IV + V",
    "M - I",
    "X / II",
    "XI * VI",
    "VII ** III",
    "V - V",
    "V / II",
    "MMM + M",
    "V - X",
);

for my $e (@examples) {
    my $pad = ' ' x (10 - length $e);
    my $output = roman_maths($e);
    print <<~"END";
    $e $pad => $output
    END
}

sub roman_maths ($equation) {
    my ( $first, $expression, $second ) = split /\s+/mx, $equation;
    my ( $f, $s ) = map { arabic($_) } $first, $second;
    my $arabic = eval( join ' ', $f, $expression, $s );
    my $roman = Roman($arabic);
    $roman = undef if $arabic =~ /\./mx;
    return $roman if defined $roman && $arabic > 0;
    return 'nulla' if $arabic == 0;
    return 'non potest' ;
}
