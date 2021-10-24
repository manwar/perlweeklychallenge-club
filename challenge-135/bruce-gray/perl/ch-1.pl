use Modern::Perl;
use Test::More;

my @tests = (
    [ 1234567, 345 ],
    [    -123, 123 ],
    [       1, 'too short' ],
    [      10, 'even number of digits' ],
);
plan tests => 0+@tests;

sub middle_three_digits {
    die if @_ != 1;
    my $a = abs shift;
    my $l = length $a;
    return 'even number of digits' if $l % 2 == 0;
    return 'too short'             if $l < 3;
    return substr $a, ($l - 3) / 2, 3;
}

for (@tests) {
    my ( $input, $expected ) = @{$_};
    my $got = middle_three_digits($input);
    is $got, $expected, "middle_three_digits($input)";
}
