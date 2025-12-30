#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Str);

=pod

=head1 NAME

ch-2.pl - Word Search

=head1 SYNOPSIS

  perl ch-2.pl BDCA
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a grid of characters and a target string, determine if the string can be
formed by an orthogonal path (up/down/left/right) without reusing a cell.

=cut

my $ARGS_CHECK = compile( ArrayRef [ArrayRef [Str]], Str );

sub word_search ($grid, $str) {
    ( $grid, $str ) = $ARGS_CHECK->( $grid, $str );
    return 1 if $str eq '';

    my $rows = scalar @$grid;
    my $cols = scalar @{ $grid->[0] };
    die 'Non-rectangular grid' if grep { @$_ != $cols } @$grid;

    my @chars = split //, $str;
    my @visited = map { [ (0) x $cols ] } 1 .. $rows;

    my $dfs;
    $dfs = sub ( $r, $c, $idx ) {
        return 1 if $idx == @chars;
        return 0 if $r < 0 || $r >= $rows || $c < 0 || $c >= $cols;
        return 0 if $visited[$r][$c];
        return 0 if $grid->[$r][$c] ne $chars[$idx];

        $visited[$r][$c] = 1;
        my $ok =
          $dfs->( $r + 1, $c, $idx + 1 ) ||
          $dfs->( $r - 1, $c, $idx + 1 ) ||
          $dfs->( $r, $c + 1, $idx + 1 ) ||
          $dfs->( $r, $c - 1, $idx + 1 );
        $visited[$r][$c] = 0;
        return $ok;
    };

    for my $r ( 0 .. $rows - 1 ) {
        for my $c ( 0 .. $cols - 1 ) {
            return 1 if $dfs->( $r, $c, 0 );
        }
    }
    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string>\n" if @args != 1;
    my $str = $args[0];
    my $grid = [
        [qw(A B D E)],
        [qw(C B C A)],
        [qw(B A A D)],
        [qw(D B B C)],
    ];
    my $out = word_search( $grid, $str ) ? 'true' : 'false';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label => 'Example 1',
            grid  => [
                [qw(A B D E)],
                [qw(C B C A)],
                [qw(B A A D)],
                [qw(D B B C)],
            ],
            str => 'BDCA',
            expected => 1,
        },
        {
            label => 'Example 2',
            grid  => [
                [qw(A A B B)],
                [qw(C C B A)],
                [qw(C A A A)],
                [qw(B B B B)],
            ],
            str => 'ABAC',
            expected => 0,
        },
        {
            label => 'Example 3',
            grid  => [
                [qw(B A B A)],
                [qw(C C C C)],
                [qw(A B A B)],
                [qw(B B A A)],
            ],
            str => 'CCCAA',
            expected => 1,
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = word_search( $case->{grid}, $case->{str} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 word_search($grid, $str)

Returns a boolean indicating whether the string can be found in the grid using
an orthogonal path without reusing cells.

=cut
