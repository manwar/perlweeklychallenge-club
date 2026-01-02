#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Knight's Move

=head1 SYNOPSIS

  perl ch-2.pl g2 a8
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a start and end square on a chessboard (e.g. C<g2> and C<a8>), compute
the least number of moves required for a knight to reach the end square.

Uses BFS on the 8x8 board.

=cut

my $POS_CHECK = compile( Str, Str );

sub _parse_pos ($pos) {
    my $p = lc $pos;
    die 'Expected coordinates like a1..h8' if $p !~ /\A[a-h][1-8]\z/;
    my ( $file, $rank ) = split //, $p;
    my $x = ord($file) - ord('a');
    my $y = $rank - 1;
    return ( $x, $y );
}

sub knights_move ($start, $end) {
    ( $start, $end ) = $POS_CHECK->( $start, $end );

    my ( $sx, $sy ) = _parse_pos($start);
    my ( $ex, $ey ) = _parse_pos($end);
    return 0 if $sx == $ex && $sy == $ey;

    my @moves = (
        [ 2,  1 ], [ 2,  -1 ], [ -2, 1 ], [ -2, -1 ],
        [ 1,  2 ], [ 1,  -2 ], [ -1, 2 ], [ -1, -2 ],
    );

    my @dist;
    for my $x ( 0 .. 7 ) {
        for my $y ( 0 .. 7 ) {
            $dist[$x][$y] = undef;
        }
    }

    my @queue = ( [ $sx, $sy ] );
    $dist[$sx][$sy] = 0;

    while (@queue) {
        my ( $x, $y ) = @{ shift @queue };
        my $d = $dist[$x][$y];

        for my $m (@moves) {
            my ( $nx, $ny ) = ( $x + $m->[0], $y + $m->[1] );
            next if $nx < 0 || $nx > 7 || $ny < 0 || $ny > 7;
            next if defined $dist[$nx][$ny];
            $dist[$nx][$ny] = $d + 1;
            return $dist[$nx][$ny] if $nx == $ex && $ny == $ey;
            push @queue, [ $nx, $ny ];
        }
    }

    die 'Unreachable position on a chessboard';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <start> <end>\n" if @args != 2;
    my ( $start, $end ) = @args;
    my $out = knights_move( $start, $end );
    say "Input:  \$start = '$start', \$end = '$end'";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', start => 'g2', end => 'a8', expected => 4 },
        { label => 'Example 2', start => 'g2', end => 'h2', expected => 3 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            knights_move( $case->{start}, $case->{end} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 knights_move($start, $end)

Returns the minimum number of knight moves required.

=cut

