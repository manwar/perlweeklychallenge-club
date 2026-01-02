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

ch-1.pl - Check Color

=head1 SYNOPSIS

  perl ch-1.pl d3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given chessboard coordinates like C<d3>, return C<true> if the square is light
and C<false> if it is dark.

Uses standard chessboard coloring where C<a1> is dark.

=cut

my $STR_CHECK = compile(Str);

sub check_color ($coordinates) {
    ($coordinates) = $STR_CHECK->($coordinates);

    my $c = lc $coordinates;
    die 'Expected coordinates like a1..h8' if $c !~ /\A[a-h][1-8]\z/;

    my ( $file, $rank ) = split //, $c;
    my $file_num = ( ord($file) - ord('a') ) + 1;

    return ( ( $file_num + $rank ) % 2 ) == 1 ? 1 : 0;    # a1 is dark
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <coordinates>\n" if @args != 1;
    my $coordinates = $args[0];
    my $out         = check_color($coordinates) ? 'true' : 'false';
    say "Input:  \$coordinates = \"$coordinates\"";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', coordinates => 'd3', expected => 1 },
        { label => 'Example 2', coordinates => 'g5', expected => 0 },
        { label => 'Example 3', coordinates => 'e6', expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( check_color( $case->{coordinates} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 check_color($coordinates)

Returns 1 for a light square, 0 for a dark square.

=cut

