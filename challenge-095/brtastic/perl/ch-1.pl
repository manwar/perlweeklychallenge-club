use v5.24;
use warnings;
use Scalar::Util qw(looks_like_number);

sub palindrome_number
{
	my ($number) = @_;

	return 0 unless looks_like_number($number);
	return 0 unless $number eq scalar reverse $number;
	return 1;
}

use Test::More;

is !palindrome_number('aoeu'), !0;
is !palindrome_number(1221), !1;
is !palindrome_number(-101), !0;
is !palindrome_number(90), !0;

done_testing;
