#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub generate_pascal_triangle {
    my $rows = shift;
    my @triangle;

    for my $i ( 0 .. $rows - 1 ) {
        my @row = (1);
        for my $j ( 1 .. $i - 1 ) {
            push @row, $triangle[ $i - 1 ][ $j - 1 ] + $triangle[ $i - 1 ][$j];
        }
        push @row, 1 if $i > 0;
        push @triangle, \@row;
    }

    return @triangle;
}

sub _run_tests {
    my @expected3 = ( [1], [ 1, 1 ], [ 1, 2, 1 ] );
    my @expected5 = ( [1], [ 1, 1 ], [ 1, 2, 1 ], [ 1, 3, 3, 1 ], [ 1, 4, 6, 4, 1 ] );

    is_deeply( [ generate_pascal_triangle(3) ], \@expected3, 'triangle(3)' );
    is_deeply( [ generate_pascal_triangle(5) ], \@expected5, 'triangle(5)' );

    done_testing();
}

sub _run_cli {
    my @args = @_;
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <rows>\n" if @args != 1 || $args[0] !~ /^\d+$/;
    my $rows = $args[0];
    die "Error: Pascal's Triangle must have at least 3 rows\n" if $rows < 3;

    my @triangle = generate_pascal_triangle($rows);
    print "Pascal's Triangle with $rows rows:\n";
    for my $i ( 0 .. $rows - 1 ) {
        my $padding = " " x ( $rows - $i - 1 );
        print "$padding", join( " ", @{ $triangle[$i] } ), "\n";
    }
}

_run_cli(@ARGV);
