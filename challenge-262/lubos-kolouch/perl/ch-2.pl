#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Count Equal Divisible (The Weekly Challenge 262 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 2 3 1 2 2 2 1 3
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>, and an integer C<$k>.

Write a script to return the number of pairs C<(i, j)> where:
a) C<0 <= i < j < size of @ints>
b) C<ints[i] == ints[j]>
c) C<i * j> is divisible by C<$k>

=head1 FUNCTIONS

=head2 count_equal_divisible($ints, $k)

Counts the number of index pairs C<(i, j)> with C<0 <= i < j < @$ints> such
that C<< $ints->[$i] == $ints->[$j] >> and C<(i * j) % $k == 0>.

=over 4

=item * C<$ints> - Reference to an array of integers.

=item * C<$k> - Positive divisor integer.

=back

Returns the total count of valid pairs.

=cut

signature_for count_equal_divisible => (
    method     => 0,
    positional => [ ArrayRef [Int], Int ],
);

sub count_equal_divisible ( $ints, $k ) {
    my $count = 0;
    my $n     = scalar @$ints;

    for my $i ( 0 .. $n - 1 ) {
        for my $j ( $i + 1 .. $n - 1 ) {
            if ( $ints->[$i] == $ints->[$j] && ( $i * $j ) % $k == 0 ) {
                $count++;
            }
        }
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $k      = int( shift @args );
    my @ints   = map { int($_) } @args;
    my $result = count_equal_divisible( \@ints, $k );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 3, 1, 2, 2, 2, 1, 3 ],
            k        => 2,
            expected => 4,
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 2, 3 ],
            k        => 1,
            expected => 0,
        },
        {
            label    => 'Empty array',
            ints     => [],
            k        => 2,
            expected => 0,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            count_equal_divisible( $case->{ints}, $case->{k} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
