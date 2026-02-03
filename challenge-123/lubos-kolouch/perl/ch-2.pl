#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Square Points

=head1 SYNOPSIS

  perl ch-2.pl                       # runs the embedded tests
  perl ch-2.pl 10 20 20 20 20 10 10 10

=head1 DESCRIPTION

Given coordinates of four points (x1,y1)..(x4,y4), determine if they form a
square. Return 1 if they do, otherwise 0.

=cut

sub _dist2 ( $a, $b ) {
    my ( $x1, $y1 ) = @$a;
    my ( $x2, $y2 ) = @$b;
    return ( $x1 - $x2 )**2 + ( $y1 - $y2 )**2;
}

sub is_square (@coords) {
    die "Expected 8 integers\n" if @coords != 8;
    my @p = (
        [ $coords[0], $coords[1] ],
        [ $coords[2], $coords[3] ],
        [ $coords[4], $coords[5] ],
        [ $coords[6], $coords[7] ],
    );

    my @d;
    for my $i ( 0 .. 3 ) {
        for my $j ( $i + 1 .. 3 ) {
            push @d, _dist2( $p[$i], $p[$j] );
        }
    }
    @d = sort { $a <=> $b } @d;

    return 0 if $d[0] == 0;                  # overlapping points
    return 0 if $d[0] != $d[1] || $d[1] != $d[2] || $d[2] != $d[3];
    return 0 if $d[4] != $d[5];
    return ( $d[4] == 2 * $d[0] ) ? 1 : 0;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 2 );
    Test::More::is( is_square( 10, 20, 20, 20, 20, 10, 10, 10 ), 1, 'Example 1' );
    Test::More::is( is_square( 12, 24, 16, 10, 20, 12, 18, 16 ), 0, 'Example 2' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 x1 y1 x2 y2 x3 y3 x4 y4\n" if @args != 8;
    say is_square(@args);
}

_run_cli(@ARGV);

