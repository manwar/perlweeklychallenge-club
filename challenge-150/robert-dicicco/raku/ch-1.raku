#!raku.exe

# Author: Robert DiCicco
# Date: 01-FEB--2022
# Challenge 150 Fibonacci Words (Raku)

my $a = '1234';
my $b = '5678';

say "Fibonacci Words";
say $a;
say $b;

my $retval = Fib(  $a, $b );
my $fibchr = substr($retval, 50, 1);
say "51st digit is $fibchr";

sub Fib ( $first, $second) {
  my $val = $first ~ $second;
  say $val;
  if $val.chars < 51 {
    Fib($second, $val);
  } else {
    return $val;
  }
}
