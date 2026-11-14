#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Reduced Row Echelon

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Given a matrix M, check whether the matrix is in reduced row echelon form
(RREF):

=over 4

=item 1. Any non-zero row has 1 as its first non-zero entry (leading 1).

=item 2. All-zero rows are grouped at the bottom of the matrix.

=item 3. Each successive non-zero row's leading 1 is strictly to the right of the previous one.

=item 4. Every column containing a leading 1 has zeros everywhere else in that column.

=back

=head1 FUNCTIONS

=head2 is_reduced_row_echelon($matrix)

Takes an ArrayRef of ArrayRefs of integers representing a matrix and returns
C<1> if it is in reduced row echelon form, or C<0> otherwise.

=cut

signature_for is_reduced_row_echelon => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ] ],
);

sub is_reduced_row_echelon ($matrix) {
    my $last_leading         = -1;
    my $zero_row_encountered = 0;

    for my $row_index ( 0 .. $#{$matrix} ) {
        my $row     = $matrix->[$row_index];
        my $leading = -1;

        for my $i ( 0 .. $#{$row} ) {
            my $element = $row->[$i];
            if ( $element != 0 ) {
                return 0 if $element != 1;
                $leading = $i;
                last;
            }
        }

        if ( $leading == -1 ) {
            $zero_row_encountered = 1;
            next;
        }

        return 0 if $zero_row_encountered;
        return 0 if $leading <= $last_leading;

        for my $r_index ( 0 .. $#{$matrix} ) {
            next if $r_index == $row_index;
            return 0 if $matrix->[$r_index][$leading] != 0;
        }

        $last_leading = $leading;
    }

    return 1;
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            input    => [ [ 1, 1, 0 ], [ 0, 1, 0 ], [ 0, 0, 0 ] ],
            expected => 0,
        },
        {
            label    => 'Example 2',
            input    => [
                [ 0, 1, -2, 0, 1 ],
                [ 0, 0, 0,  1, 3 ],
                [ 0, 0, 0,  0, 0 ],
                [ 0, 0, 0,  0, 0 ],
            ],
            expected => 1,
        },
        {
            label    => 'Example 3',
            input    => [ [ 1, 0, 0, 4 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ],
            expected => 1,
        },
        {
            label    => 'Example 4',
            input    => [
                [ 0, 1, -2, 0, 1 ],
                [ 0, 0, 0,  0, 0 ],
                [ 0, 0, 0,  1, 3 ],
                [ 0, 0, 0,  0, 0 ],
            ],
            expected => 0,
        },
        {
            label    => 'Example 5',
            input    => [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 0 ] ],
            expected => 0,
        },
        {
            label    => 'Example 6',
            input    => [ [ 4, 0, 0, 0 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ],
            expected => 0,
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is(
            is_reduced_row_echelon( $case->{input} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
