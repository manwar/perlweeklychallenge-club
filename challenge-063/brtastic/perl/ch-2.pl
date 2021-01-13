use v5.24;
use warnings;

sub rotate_string
{
	my ($string) = @_;
	my $original = $string;
	my $length = length $string;

	my $rotate = sub {
		substr shift() x 2, $_, $length
	};

	my $rotation = 0;
	while (1) {
		for (1 .. $length) {
			$rotation += 1;
			$string = $rotate->($string);

			return $rotation if $original eq $string;
		}
	}
}

use Test::More;

is rotate_string('xy'), 3;
is rotate_string('xyxx'), 7;
is rotate_string('xxxx'), 1;
is rotate_string('xyxy'), 3;
is rotate_string('xxyy'), 7;
is rotate_string('xxxxx'), 1;
is rotate_string('xyyxx'), 4;
is rotate_string('xyyxxyyyxxx'), 10;

done_testing;
