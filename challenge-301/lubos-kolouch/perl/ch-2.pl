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

ch-2.pl - Hamming Distance

=head1 SYNOPSIS

  perl ch-2.pl 4 14 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Returns the sum of Hamming distances between all pairs of integers in the
array, where Hamming distance is the number of differing bits in binary
representation.

Uses bit counting via XOR for each pair.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub _popcount ($n) {
    my $count = 0;
    while ($n) {
        $n &= ( $n - 1 );
        ++$count;
    }
    return $count;
}

sub hamming_distance_sum ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    return 0 if @$ints < 2;

    my $sum = 0;
    for my $i ( 0 .. $#$ints - 1 ) {
        for my $j ( $i + 1 .. $#$ints ) {
            $sum += _popcount( $ints->[$i] ^ $ints->[$j] );
        }
    }
    return $sum;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = hamming_distance_sum( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 4, 14, 2 ], expected => 6 },
        { label => 'Example 2', ints => [ 4, 14, 4 ], expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( hamming_distance_sum( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 hamming_distance_sum($ints)

Returns the sum of bitwise Hamming distances across all unordered pairs.

=cut
