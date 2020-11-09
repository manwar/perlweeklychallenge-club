#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(all any);
use Storable qw(dclone);

use Getopt::Long qw(:config auto_help);
use Pod::Usage;

{

    my $INPUT = slurp(*STDIN);

    my @SUDOKU = map {
        [ map { $_ eq '_' ? undef : $_ } grep { /[0-9_]/ } split( /\s*/, $_ ) ]
    } split( /\n/, $INPUT );

    pod2usage( -message => "Invalid input", -exitval => 1 )
      unless all { @$_ == 9 } @SUDOKU;

    my $solved = solve( \@SUDOKU );

    die "no solution found\n" unless $solved;
    say render_sudoku($solved);
}

sub render_sudoku($sudoku) {
    join(
        "\n",
        map {
            join( ' ', '[', map { $_ // '_' } @$_, ']' )
        } @$sudoku
    );
}

sub solve($sudoku) {
    return $sudoku if solved($sudoku);

    my %cache;
    while ( my %next = next_free_position( $sudoku, \%cache ) ) {
        my $row = $next{row};
        my $col = $next{col};
        $cache{ $row . $col } = 1;

        for my $candidate ( @{ $next{domain} } ) {
            my $test = [@$sudoku];
            $test->[$row] = [ @{ $test->[$row] } ];
            $test->[$row][$col] = $candidate;
            my $solved = solve($test);
            return $solved if $solved;
        }
    }
}

sub next_free_position ( $sudoku, $cache ) {
    my %min;
    for my $row ( 0 .. 8 ) {
        for my $col ( 0 .. 8 ) {
            next if defined $sudoku->[$row][$col] || $cache->{ $row . $col };
            my @domain = get_candidates( $row, $col, $sudoku );
            return if !@domain;

            if ( !%min || @domain < @{ $min{domain} } ) {
                %min = (
                    row    => $row,
                    col    => $col,
                    domain => \@domain,
                );
            }
        }
    }

    return %min;
}

sub get_candidates ( $row, $col, $sudoku ) {
    intersection(
        [ col_candidates( $col, $sudoku ) ],
        [ row_candidates( $row, $sudoku ) ],
        [ box_candidates( $row, $col, $sudoku ) ]
    );
}

sub solved($sudoku) {
    all { !row_candidates( $_, $sudoku ) } 0 ... 8;
}

sub row_candidates ( $row, $sudoku ) {
    _missing( @{ $sudoku->[$row] } );
}

sub col_candidates ( $col, $sudoku ) {
    _missing( map { $_->[$col] } @{$sudoku} );
}

sub box_candidates ( $row, $col, $sudoku ) {

    my $box_start_row = int( $row / 3 ) * 3;
    my $box_start_col = int( $col / 3 ) * 3;

    my @elems =
      map { @{$_}[ $box_start_col .. $box_start_col + 2 ] }
      ( @{$sudoku}[ $box_start_row .. $box_start_row + 2 ] );
    return _missing(@elems);
}

sub _missing(@elems) {
    state $domain = [ 1 .. 9 ];
    difference( $domain, \@elems );
}

sub difference ( $a, $b ) {
    my %b_lookup = map { $_ ? ( $_ => 1 ) : () } @$b;
    grep { !$b_lookup{$_} } @$a;
}

sub intersection ( $a, $b, @more ) {
    my %a_lookup = map { $_ => 1 } @$a;
    my @res =
      grep {
        my $b_elem = $_;
        $a_lookup{$b_elem};
      } @$b;

    return @res if !@more;
    return intersection( \@res, @more );
}

sub slurp($fh) {
    local $/ = undef;
    my $out = <$fh>;
    return $out;
}

=pod

=head1 NAME

wk-086 ch-2 - Sudoku Puzzle

=head1 SYNOPSIS

ch-2.pl [options]

  This programm will complete the given Sudoku Puzzle

  Options:
    --help       print this help text

=cut
