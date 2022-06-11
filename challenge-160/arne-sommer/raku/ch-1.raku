#! /usr/bin/env raku

unit sub MAIN (Int $n is copy where 0 < $n < 10);

my @names =
[
  "zero",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine"
];

my @result;

repeat
{
  my $text   = @names[$n];
  my $length = $text.chars;

  @result.push: "$text is @names[$length]";
  $n = $length;
} while $n != 4;

say tc(@result.join(", ")) ~ ", four is magic.";