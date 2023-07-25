#!/usr/bin/env raku
use Math::Roman; # it's v0.0.1, but usable

sub isroman ( $var ) {
  # Math::Roman doesn't have a test to see if a string is
  # a Roman numeral, but it does throw an exception if it
  # cannot convert it
  my $result;
  try {
    CATCH {
      default {
        return False;
      }
    }
    $result = Math::Roman.new: $var;
  }
  # Math::Roman also doesn't respect the maximum of 3999
  if ($result.as-arabic > 3999) {
    return False;
  }

  return True;
}

sub do_arithmetic (Str $line) {
  # split the inout line into the three parts:
  # the two operands and the infix operator
  my ($operand1, $operator, $operand2) = $line.split(/\s+/);

  unless (defined $operand1 &&
          defined $operator  &&
          defined $operand2) {
    say q{Lines must be of the form "operand1 operator operand2"};
    say q{where both operands are valid roman numerals and the};
    say q{operator is one of the following:  +  -  *  /  **};
    return;
  }

  # check that the first operand is a roman numeral
  if (isroman($operand1)) {
    # it is a roman numeral, convert it
    $operand1 = Math::Roman.new: $operand1;
  }
  else {
    say "'$operand1' is not a roman numberal!";
    return;
  }

  # check that the second operand is a roman numeral
  if (isroman($operand2)) {
    # it is a roman numeral, convert it
    $operand2 = Math::Roman.new: $operand2;
  }
  else {
    say "'$operand2' is not a roman numberal!";
    return;
  }

  # # calculate the results
  my $result;
  if ($operator eq '+')     {
    $result = $operand1.as-arabic + $operand2.as-arabic;
  }
  elsif ($operator eq '-')  {
    $result = $operand1.as-arabic - $operand2.as-arabic;
  }
  elsif ($operator eq '*')  {
    $result = $operand1.as-arabic * $operand2.as-arabic;
  }
  elsif ($operator eq '/')  {
    $result = $operand1.as-arabic / $operand2.as-arabic;
  }
  elsif ($operator eq '**') {
    $result = $operand1.as-arabic ** $operand2.as-arabic;
  }
  else {
    die "Unknown operator '$operator'; valid operators are + - * / **\n";
  }

  # handle all the special output cases
  if ($result == 0) {
    say "$operand1 $operator $operand2 => nulla "
      ~ "(they knew about zero but didn't have a symbol)";
  }
  elsif ($result.truncate != $result) {
    say "$operand1 $operator $operand2 => non potest "
      ~ "(they didn't do fractions)";
  }
  elsif ($result > 3999) {
    say "$operand1 $operator $operand2 => non potest "
      ~ "(they only went up to 3999)";
  }
  elsif ($result < 0) {
    say "$operand1 $operator $operand2 => non potest "
      ~ "(they didn't do negative numbers)";
  }
  else {
    $result = Math::Roman.new: value => $result.Int;
    say "$operand1 $operator $operand2 => $result";
  }
}

# while we have input on STDIN, process the calculations
for $*IN.lines -> $line {
  do_arithmetic($line);
}