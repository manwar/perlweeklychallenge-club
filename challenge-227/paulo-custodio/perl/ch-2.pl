#!/usr/bin/env perl

# Challenge 227
#
# Task 2: Roman Maths
# Submitted by: Peter Campbell Smith
# Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.
#
# Example
# IV + V     => IX
# M - I      => CMXCIX
# X / II     => V
# XI * VI    => LXVI
# VII ** III => CCCXLIII
# V - V      => nulla (they knew about zero but didn't have a symbol)
# V / II     => non potest (they didn't do fractions)
# MMM + M    => non potest (they only went up to 3999)
# V - X      => non potest (they didn't do negative numbers)

use Modern::Perl;
use Math::Roman;

my $roman_re = qr/[IVXLCDM]+/;
my $op_re = qr/\*\*|[-+*\/]/;

my $expr = "@ARGV";
$expr =~ /^\s*($roman_re)\s*($op_re)\s*($roman_re)\s*$/ or die "invalid expression\n";
my($a, $op, $b) = ($1, $2, $3);
$a = Math::Roman->new($a);
$b = Math::Roman->new($b);
my $num_expr = $a->as_number().$op.$b->as_number();
my $result = eval($num_expr);
$@ and die "$num_expr: $@";

if ($result == 0) {
    say "nulla";
}
elsif (int($result) != $result) {
    say "non potest";
}
elsif ($result < 0) {
    say "non potest";
}
elsif ($result > 3999) {
    say "non potest";
}
else {
    say Math::Roman->new($result);
}
