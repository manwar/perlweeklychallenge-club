#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(sum0);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Sum Difference

=head1 SYNOPSIS

  perl ch-2.pl 1 23 4 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Computes the absolute difference between the sum of array elements and the sum
of all digits across those elements.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub sum_difference ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    die 'Expected positive integers only' if grep { $_ <= 0 } @$ints;

    my $element_sum = sum0(@$ints);
    my $digit_sum   = 0;
    for my $n (@$ints) {
        $digit_sum += sum0( split //, $n );
    }

    my $diff = $element_sum - $digit_sum;
    return $diff < 0 ? -$diff : $diff;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints = map { 0 + $_ } @args;
    my $out  = sum_difference( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 23, 4, 5 ], expected => 18 },
        { label => 'Example 2', ints => [ 1, 2, 3, 4, 5 ], expected => 0 },
        { label => 'Example 3', ints => [ 1, 2, 34 ], expected => 27 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( sum_difference( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sum_difference($ints)

Returns C<abs(sum(@ints) - sum(digits(@ints)))>.

=cut
