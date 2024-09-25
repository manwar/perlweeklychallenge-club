#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

=pod

=head1 DESCRIPTION

This script finds the closest palindrome integer to a given integer string,
excluding the integer itself. If there are multiple palindromes with the same
minimal absolute difference, it returns the smallest one.

=head1 FUNCTIONS

=head2 closest_palindrome($str)

Given a string representing an integer, returns the closest palindrome as per
the problem definition.

=over 4

=item * C<$str> - The input integer as a string.

=back

Returns the closest palindrome integer as a string.

=cut

sub closest_palindrome {
    my ($n_str) = @_;
    my $n = int($n_str);
    my $len = length($n_str);
    my $is_even = $len % 2 == 0;
    my $mid = int($len / 2);

    # Obtain the left part of the number
    my $left_len = $is_even ? $mid : $mid + 1;
    my $left = substr($n_str, 0, $left_len);
    my @candidates;

    foreach my $i (-1, 0, 1) {
        my $new_left = int($left) + $i;
        next if $new_left < 0;
        my $new_left_str = "$new_left";

        my $palindrome;
        if ($is_even) {
            $palindrome = $new_left_str . reverse($new_left_str);
        } else {
            $palindrome = $new_left_str . reverse(substr($new_left_str, 0, -1));
        }
        push @candidates, $palindrome;
    }

    # Edge cases
    push @candidates, ('9' x ($len - 1)) if $len > 1;
    push @candidates, '1' . ('0' x ($len - 1)) . '1';

    # Remove the original number from candidates
    @candidates = grep { $_ ne $n_str } @candidates;

    # Find the closest palindrome
    my $min_diff = undef;
    my $closest_palindrome = undef;
    foreach my $candidate (@candidates) {
        my $diff = abs(int($candidate) - $n);
        if (!defined $min_diff || $diff < $min_diff || ($diff == $min_diff && int($candidate) < int($closest_palindrome))) {
            $min_diff = $diff;
            $closest_palindrome = $candidate;
        }
    }
    return $closest_palindrome;
}

# Unit Tests
is(closest_palindrome("123"), "121", 'Example 1');
is(closest_palindrome("2"), "1", 'Example 2');
is(closest_palindrome("1400"), "1441", 'Example 3');
is(closest_palindrome("1001"), "999", 'Example 4');

done_testing();
