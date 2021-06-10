#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::BigRat;
use Math::Prime::Util
    qw(carmichael_lambda valuation fordivisors lastfor factor);
use List::Util qw(max reduce);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [--] [numerator denominator]

-examples
    run the examples from the challenge
 
-tests
    run some tests

numerator denominator
    transform the fraction numerator/denominator into a decimal number
    with a parenthesized repetend, if any.

EOS


### Input and Output

say frac("$ARGV[0]/$ARGV[1]");


### Implementation

BEGIN {
    # Truncate instead of rounding.
    Math::BigFloat->round_mode('trunc');
}

# Convert a fraction into its decimal representation, highlighting a
# repetend.
#
# We *could* perform a long division, record the occurring remainders
# after the numerator has been exhausted and stop at the first
# repetition.  But...
#
# Here is a different plan:
# Perform a BigRat division with a sufficient number of significant
# digits.  Then truncate the result at the end of a repetend and find
# the true repetend.  The required number of digits is composed of the
# integer part's length, the length of a non-repeating sequence and an
# estimate for the period, i.e. a (preferably small) multiple of it.
# The integer part is facile.
# For the length of the non-repeating sequence we have to find the
# powers of 2 and 5 in the denominator.  Each factor 2, 5 or 10 adds
# one digit.  Thus the length of the non-repeating sequence is the
# maximum exponent of 2 and 5 in the denominator.
# For an estimate of the period we need to find the largest divisor in
# the denominator that is coprime to 10, i.e. the denominator with all
# powers of the common factors removed.
# The period of the reciprocal of the coprime denominator cannot be
# larger than the maximum order of this reduced denominator as an
# element of the multiplicative group of integers modulo k (for any
# coprime k), which is given by Carmichael's lambda function.
# See
# https://en.wikipedia.org/wiki/Repeating_decimal#Reciprocals_of_composite_integers_coprime_to_10
# and https://en.wikipedia.org/wiki/Carmichael_function
# Luckily the lambda function is provided by the awesome
# Math::Prime::Util module.
# Finally, put the actual repetend in parentheses.
sub frac {
    # Create a fraction object.
    my $frac = Math::BigRat->new(shift);

    # Done.
    return "$frac" if $frac->is_int;

    # Find the powers of 2 and 5 in the denominator and their maximum
    # exponent.
    my %pow = map {($_ => valuation $frac->denominator, $_)} factor 10;
    my $nlen = max values %pow;

    # Find the largest divisor in the denominator that is coprime to 10.
    my $coprime =
        reduce {$a->bdiv($b ** $pow{$b})} $frac->denominator, keys %pow;

    # Get an estimate for the period of the reciprocal of the coprime
    # denominator.
    my $rlen = carmichael_lambda $coprime;

    # Check the limit for quantifiers in regexp's.
    die "period possibly too large, giving up" if $rlen >= 2 ** 15 - 1;

    # Convert the BigRat via BigFloat into a string ending in the
    # repetend.
    my $decimal .= $frac
        ->as_float($frac->as_int->length + $nlen + $rlen)
        ->bfround(-($nlen + $rlen));

    # The actual period is a divisor of the maximum period.  Try all
    # divisors in ascending order up to the first match.
    fordivisors {
        # Number of repetitions.
        my $rep = $rlen / $_ - 1;

        # Enclose the repetend in parentheses or remove zeroes.
        lastfor if $decimal =~
            s/^.*?\..{$nlen}\K(.{$_})\1{$rep}$/"($1)" x !!$1/e;
    } $rlen;

    $decimal;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is frac('1/3'), '0.(3)', 'example 1';
        is frac('1/2'), '0.5', 'example 2';
        is frac('5/66'), '0.0(75)', 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        # From Wikipedia
        is frac('1/49'),
            '0.(020408163265306122448979591836734693877551)',
            'example 1 from Wikipedia page';
        is frac('1/119'),
            '0.(008403361344537815126050420168067226890756302521)',
            'example 2 from Wikipedia page';

        # Implementation test cases
        is frac('12222/9900'), '1.23(45)', 'has non-repeating sequence';
        is frac('1100000012/990000'),
            '1111.1111(23)',
            'non-repeating sequence longer than repetend';
        is frac('1/108'), '0.00(925)', 'zero integer and non-repeating part';
        is frac('1/6'), '0.1(6)', 'would fail with rounding';

        # some reciprocals
        is frac('1/1'), '1', '1/1';
        is frac('1/2'), '0.5', '1/2';
        is frac('1/3'), '0.(3)', '1/3';
        is frac('1/4'), '0.25', '1/4';
        is frac('1/5'), '0.2', '1/5';
        is frac('1/7'), '0.(142857)', '1/7';
        is frac('1/8'), '0.125', '1/8';
        is frac('1/9'), '0.(1)', '1/9';
        is frac('1/10'), '0.1', '1/10';
        is frac('1/11'), '0.(09)', '1/11';
        is frac('1/12'), '0.08(3)', '1/12';
	}

    done_testing;
    exit;
}
