#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Shift Grid

=head1 SYNOPSIS

  perl ch-2.pl 1            # runs the embedded tests

=head1 DESCRIPTION

Shifts an m x n matrix to the right by C<k> steps following the wrap rules from
the challenge statement. This is equivalent to shifting the flattened array by
k positions to the right (mod m*n) and reshaping back.

=cut

my $ARGS_CHECK = compile( ArrayRef [ArrayRef [Int]], Int );

sub shift_grid ($matrix, $k) {
    ( $matrix, $k ) = $ARGS_CHECK->( $matrix, $k );
    die 'Expected k > 0' if $k <= 0;
    return [] if !@$matrix;

    my $rows = scalar @$matrix;
    my $cols = scalar @{ $matrix->[0] };
    die 'Non-rectangular matrix' if grep { @$_ != $cols } @$matrix;

    my @flat;
    push @flat, @$_ for @$matrix;

    my $len = @flat;
    my $shift = $k % $len;
    my @shifted =
      $shift == 0
      ? @flat
      : ( @flat[ $len - $shift .. $len - 1 ], @flat[ 0 .. $len - $shift - 1 ] );

    my @out;
    for my $r ( 0 .. $rows - 1 ) {
        push @out, [ @shifted[ $r * $cols .. $r * $cols + $cols - 1 ] ];
    }
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <k> <row1;row2;...>\n" if @args != 2;
    my $k = 0 + $args[0];
    my @rows = split /;/, $args[1];
    my @matrix = map { [ map { 0 + $_ } split /,/, $_ ] } @rows;
    my $out = shift_grid( \@matrix, $k );
    say "Output: (" . join( ", ", map { '[' . join( ', ', @$_ ) . ']' } @$out ) . ")";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label  => 'Example 1',
            matrix => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            k      => 1,
            expected => [ [ 9, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ] ],
        },
        {
            label  => 'Example 2',
            matrix => [ [ 10, 20 ], [ 30, 40 ] ],
            k      => 1,
            expected => [ [ 40, 10 ], [ 20, 30 ] ],
        },
        {
            label  => 'Example 3',
            matrix => [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ],
            k      => 1,
            expected => [ [ 6, 1 ], [ 2, 3 ], [ 4, 5 ] ],
        },
        {
            label  => 'Example 4',
            matrix => [ [ 1, 2, 3 ], [ 4, 5, 6 ] ],
            k      => 5,
            expected => [ [ 2, 3, 4 ], [ 5, 6, 1 ] ],
        },
        {
            label  => 'Example 5',
            matrix => [ [ 1, 2, 3, 4 ] ],
            k      => 1,
            expected => [ [ 4, 1, 2, 3 ] ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = shift_grid( $case->{matrix}, $case->{k} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 shift_grid($matrix, $k)

Returns a new matrix after shifting C<$k> times according to the rules.

=cut
