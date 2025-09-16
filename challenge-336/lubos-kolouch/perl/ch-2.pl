#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-2.pl - The Weekly Challenge 336 Task 2: Final Score

=head1 DESCRIPTION

Compute the total score for a sequence of operations. Each entry is one of:

=over 4

=item * an integer representing a new score,

=item * C<'C'> to invalidate and remove the previous score,

=item * C<'D'> to record double the previous score, or

=item * C<'+'> to add the sum of the previous two scores.

=back

The solution tracks scores on a stack and sums the remaining values.

=head1 AUTHOR

Lubos Kolouch

=cut

use List::Util qw(sum0);
use Test::More tests => 5;

use constant ScoreList => 'ARRAY';

sub final_score {
    my (@entries) = @_;
    my @record;

    for my $entry (@entries) {
        if ( $entry eq 'C' ) {
            pop @record;
        }
        elsif ( $entry eq 'D' ) {
            push @record, 2 * $record[-1];
        }
        elsif ( $entry eq '+' ) {
            push @record, $record[-1] + $record[-2];
        }
        else {
            push @record, 0 + $entry;
        }
    }

    return sum0(@record);
}

subtest 'Example 1' => sub {
    my @scores = qw(5 2 C D +);
    is( final_score(@scores), 30, 'Total score 30' );
};

subtest 'Example 2' => sub {
    my @scores = qw(5 -2 4 C D 9 + +);
    is( final_score(@scores), 27, 'Total score 27' );
};

subtest 'Example 3' => sub {
    my @scores = qw(7 D D C + 3);
    is( final_score(@scores), 45, 'Total score 45' );
};

subtest 'Example 4' => sub {
    my @scores = qw(-5 -10 + D C +);
    is( final_score(@scores), -55, 'Total score -55' );
};

subtest 'Example 5' => sub {
    my @scores = qw(3 6 + D C 8 + D -2 C +);
    is( final_score(@scores), 128, 'Total score 128' );
};
