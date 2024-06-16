use strict;
use warnings;

use v5.38;

my @inputs = (
    ['perl', 'e'],
    ['java', 'a'],
    ['python', 'm'],
    ['ada', 'a'],
    ['ada', 'd'],
    ['ballerina', 'l'],
    ['analitik', 'k'],
    ['aaabb', 'a'],
    ['aaabb', 'b'],
    ['aaaabbb', 'a'],
    ['aaaabbb', 'b'],
    );

for my $input (@inputs) {
    say "char:$$input[1], string:$$input[0] => " . percent_char_string( $$input[1], $$input[0] );
}

sub percent_char_string( $char, $string ) {
    # do all arithmetic in integer domain
    use integer;

    # get the length of $string
    my $length = length( $string );

    # count how many characters match $char
    my $sum_chars = $string =~ s"$char""g;

    # find the integer division of $sum_chars / $length
    # then figure out if we would round up or down and add 1 or 0 respectively
    my $result = $sum_chars * 100 / $length + (($sum_chars * 100 % $length) * 2 >= $length );

    return $result;
}
