#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Num);

=pod

=head1 NAME

ch-1.pl - Distinct Average

=head1 SYNOPSIS

  perl ch-1.pl 1 2 4 3 5 6
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Repeatedly remove the minimum and maximum values from the list, compute their
average, and return the number of distinct averages observed.

The list length is guaranteed to be even in the task statement.

=cut

my $LIST_CHECK = compile( ArrayRef [Num] );

sub distinct_average_count ($nums) {
    ($nums) = $LIST_CHECK->($nums);
    die 'Expected an even-length list' if @$nums % 2 != 0;

    my @sorted = sort { $a <=> $b } @$nums;
    my %seen;

    for ( my ( $l, $r ) = ( 0, $#sorted ); $l < $r; ++$l, --$r ) {
        my $sum = $sorted[$l] + $sorted[$r];
        $seen{ sprintf( '%.12g', $sum ) } = 1;    # store 2*avg as stable key
    }

    return scalar keys %seen;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @nums = map { 0 + $_ } @args;
    my $out  = distinct_average_count( \@nums );
    say 'Input:  @nums = (' . join( ', ', @nums ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', nums => [ 1, 2, 4, 3, 5, 6 ], expected => 1 },
        { label => 'Example 2', nums => [ 0, 2, 4, 8, 3, 5 ], expected => 2 },
        { label => 'Example 3', nums => [ 7, 3, 1, 0, 5, 9 ], expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is(
            distinct_average_count( $case->{nums} ),
            $case->{expected},
            $case->{label},
        );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 distinct_average_count($nums)

Accepts an array reference of numbers and returns the number of distinct
averages seen while removing the current minimum and maximum at each step.

=cut
