#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two complex numbers as string.

Write a script to return the multiplication of the given complex numbers.

    Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i

Example 1

Input: $num1 = "1+1i", $num2 = "1+1i"
Output: "0+2i"

Example 2

Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
Output: "0+(-2)i"

Example 3

Input: $num1 = "0+3i", $num2 = "0+4i"
Output: "-12+0i"

Example 4

Input: $num1 = "3+4i", $num2 = "3+(-4)i"
Output: "25+0i"

Example 5

Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
Output: "100+1700i"

=cut



use Test2::V0 -no_srand => 1;
is(complex_mult("1+1i", "1+1i"), '0+2i', 'Example 1');
is(complex_mult("1+(-1)i", "1+(-1)i"), '0+(-2)i', 'Example 2');
is(complex_mult("0+3i", "0+4i"), '-12+0i', 'Example 3');
is(complex_mult("3+4i", "3+(-4)i"), '25+0i', 'Example 4');
is(complex_mult("50+(-20)i", "-10+30i"), '100+1700i', 'Example 5');
done_testing();


sub complex_mult
{
     my ($num_1, $num_2) = @_;
     my %n_1 = parse_complex_number($num_1);
     my %n_2 = parse_complex_number($num_2);

     my $part_1 = ($n_1{real} * $n_2{real} - $n_1{img} * $n_2{img});
     my $part_2 = ($n_1{real} * $n_2{img} + $n_1{img} * $n_2{real});

     return join('+', $part_1, 
            join('', $part_2 < 0 ? "($part_2)" : $part_2, 'i'));
}

sub parse_complex_number
{
     my $str = $_[0]; 
     my $num_re = qr/\-?\d+/;

     my ($real, $img) = $str =~ /^($num_re)\+\(?($num_re)\)?i/;
     my %complex = ('real' => $real, 'img' => $img);
     return %complex;
}
