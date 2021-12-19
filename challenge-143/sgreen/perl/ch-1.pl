#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::MoreUtils 'firstidx';

sub _parts {
    my $s         = shift;
    my $re_number = qr'-?[0-9]+(?:\.[0-9]+)?';
    my $re_op     = qr'[-+*]';
    my ( $op, $number );

    if ( $s !~ /^\s*$re_number(?:\s*$re_op\s*$re_number)*\s*$/ ) {
        die "String $s not valid\n";
    }

    # Split the string into number op number op number ...
    my @parts = ();
    ( $parts[0], $s ) = ( $s =~ /^\s*($re_number)\s*(.*)$/ );
    while ( ( $op, $number, $s ) = ( $s =~ /($re_op)\s*($re_number)\s*(.*)/ ) ) {
        push @parts, $op, $number;
    }

    return @parts;
}

sub _calc {
    my $c = shift;

    my @equation = _parts($c);

    # Match all multipliers
    while ( ( my $idx = firstidx { $_ eq '*' } @equation ) != -1 ) {
        splice( @equation, $idx - 1, 3, $equation[ $idx - 1 ] * $equation[ $idx + 1 ] );
    }

    # Match all addition / subtraction
    while ( @equation > 1 ) {
        $equation[2] = -$equation[2] if $equation[1] eq '-';
        splice( @equation, 0, 3, $equation[0] + $equation[2] );
    }

    return $equation[0];
}

sub main {
    my $s = shift;

    # Reduce parenthesis (inner most first)
    while ( $s =~ /\(.*\)/ ) {
        $s =~ s/\(([^()]*)\)/ ' ' . _calc($1) . ' ' /e;
    }

    # We should now be left with simple a op b op c ...
    say _calc($s);
}

main(@ARGV);
