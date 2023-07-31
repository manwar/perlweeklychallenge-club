#!/usr/bin/env perl
use v5.38;

use Roman; # there's a module for handling Roman Numerals!

sub do_arithmetic {
  my $line = shift;
  # split the inout line into the three parts:
  # the two operands and the infix operator
  my($operand1r, $operator, $operand2r) = split /\s+/, $line;
  unless (defined $operand1r &&
          defined $operator  &&
          defined $operand2r) {
    say q{Lines must be of the form "operand1 operator operand2"};
    say q{where both operands are valid roman numerals and the};
    say q{operator is one of the following:  +  -  *  /  **};
    return;
  }

  my($operand1a, $operand2a);

  # check that the first operand is a roman numeral
  if (isroman($operand1r)) {
    # it is a roman numeral, convert it
    $operand1a = arabic($operand1r);
  }
  else {
    say "'$operand1r' is not a roman numberal!";
    return;
  }

  # check that the second operand is a roman numeral
  if (isroman($operand2r)) {
    # it is a roman numeral, convert it
    $operand2a = arabic($operand2r);
  }
  else {
    say "'$operand2r' is not a roman numberal!";
    return;
  }

  # calculate the results
  my $result;
  if ($operator eq '+')     { $result = $operand1a + $operand2a; }
  elsif ($operator eq '-')  { $result = $operand1a - $operand2a; }
  elsif ($operator eq '*')  { $result = $operand1a * $operand2a; }
  elsif ($operator eq '/')  { $result = $operand1a / $operand2a; }
  elsif ($operator eq '**') { $result = $operand1a ** $operand2a; }
  else {
    die "Unknown operator '$operator'; valid operators are + - * / **\n";
  }

  # handle all the special output cases
  if ($result == 0) {
    say "$operand1r $operator $operand2r => nulla "
      . "(they knew about zero but didn't have a symbol)";
  }
  elsif (int($result) != $result) {
    say "$operand1r $operator $operand2r => non potest "
      . "(they didn't do fractions)";
  }
  elsif ($result > 3999) {
    say "$operand1r $operator $operand2r => non potest "
      . "(they only went up to 3999)";
  }
  elsif ($result < 0) {
    say "$operand1r $operator $operand2r => non potest "
      . "(they didn't do negative numbers)";
  }
  else {
    say "$operand1r $operator $operand2r => " . uc roman($result);
  }
}

# while we have input on STDIN, process the calculations
while (my $line = <>) {
  chomp $line;
  do_arithmetic($line);
}