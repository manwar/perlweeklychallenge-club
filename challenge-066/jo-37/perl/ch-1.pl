#!/usr/bin/perl

use Test2::V0;

# Apply the sign of the second argument to the first.
sub apply {
	my ($value, $sign) = @_;

	$sign >= 0 ? $value : -$value;
}

# Return floor of dividend divided by divisor.
# Performs basically a long division.
sub divide {
	my ($dividend, $divisor) = @_;
	die 'divisor is zero' unless $divisor;

	# Save sign.
	my $sign = apply $dividend, $divisor;

	# Take absolute values of parameters.
	$dividend = apply $dividend, $dividend;
	$divisor = apply $divisor, $divisor;

	# long division
	my ($quotient, $remainder);
	while (length $dividend > 0) {
		$remainder .= substr $dividend, 0, 1, '';
		my $digit = 0;
		for (; $remainder >= $divisor; $remainder -= $divisor) {
			$digit++;
		}
		$quotient .= $digit;
	}

	# Restore sign and adjust result.
	apply($quotient, $sign) - ($sign < 0 && $remainder > 0 ? 1 : 0);
}

is divide(0, 2), 0, 'zero numerator';

eval {divide(1, 0)};
is $@, D(), 'division by zero';

is divide(5, 2), 2, 'first example';
is divide(-5, 2), -3, 'second example';
is divide(-5, -2), 2, 'third example';
is divide(5, -2), -3, 'like second example';
is divide(6, 2), 3, 'first divisible example';
is divide(-6, 2), -3, 'second divisible example';
is divide(-6, -2), 3, 'third divisible example';
is divide(6, -2), -3, 'like second divisible example';
is divide(2, 3), 0, 'zero';
is divide(-2 , 3), -1, 'negative';
is divide(12345, 23), 536, 'larger positive non divisable';
is divide(-12345, 23), -537, 'larger negative non divisable';
is divide(12328, 23), 536, 'larger positive divisable';
is divide(-12328, 23), -536, 'larger negative divisable';
is divide(101101, 101), 1001, 'many zeros, positive';
is divide(-101100, 101), -1001, 'many zeros, negative';
is divide(9223372036854775808, 16), 576460752303423488, 'very large dividend';

done_testing;
