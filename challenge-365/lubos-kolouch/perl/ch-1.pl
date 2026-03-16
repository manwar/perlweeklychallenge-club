#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

AlphabetIndexDigitSum - Convert string to numbers, sum digits K times

=head1 SYNOPSIS

    use strict;
    use warnings;
    use lib '.';
    require AlphabetIndexDigitSum;

    my $result = alphabet_index_digit_sum("abc", 1);  # 6
    my $result = alphabet_index_digit_sum("az", 2);  # 9

=head1 DESCRIPTION

Given a string of lowercase letters and an integer K:
1. Convert each letter to its alphabet position (a=1, b=2, ..., z=26)
2. Concatenate the numbers to form an integer
3. Sum the digits repeatedly K times
4. Return the final value

=cut

=head1 SUBROUTINES

=head2 alphabet_index_digit_sum($str, $k)

    my $result = alphabet_index_digit_sum("abc", 1);

Performs the digit sum calculation K times.

Parameters:
    $str - string of lowercase letters
    $k   - number of times to sum digits

Returns:
    The final digit sum after K iterations.

=cut

sub alphabet_index_digit_sum {
    my ($str, $k) = @_;

    die "Error: str must be defined\n" unless defined $str;
    die "Error: k must be a positive integer\n" unless defined $k && $k =~ /^\d+$/;

    my $numbers = '';
    for my $char (split //, $str) {
        my $ord = ord($char) - ord('a') + 1;
        $numbers .= $ord;
    }

    my $sum = 0;
    for my $digit (split //, $numbers) {
        $sum += $digit;
    }

    for my $i (2 .. $k) {
        my $new_sum = 0;
        for my $digit (split //, $sum) {
            $new_sum += $digit;
        }
        $sum = $new_sum;
    }

    return $sum;
}

=head2 _digit_sum($num)

    my $sum = _digit_sum(123);

Helper function to sum digits of a number.

=cut

sub _digit_sum {
    my ($num) = @_;
    my $sum = 0;
    for my $digit (split //, $num) {
        $sum += $digit;
    }
    return $sum;
}

is(alphabet_index_digit_sum("abc", 1), 6, 'Example 1: abc k=1 -> 6');
is(alphabet_index_digit_sum("az", 2), 9, 'Example 2: az k=2 -> 9');
is(alphabet_index_digit_sum("cat", 1), 6, 'Example 3: cat k=1 -> 6');
is(alphabet_index_digit_sum("dog", 2), 8, 'Example 4: dog k=2 -> 8');
is(alphabet_index_digit_sum("perl", 3), 6, 'Example 5: perl k=3 -> 6');

done_testing();
