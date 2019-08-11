#! /usr/bin/env perl
use v5.22;

sub sum_of_proper_divisors {
  #start with one, because that is always a divisor
  my $sum = 1;
  (1 x shift) =~ /^ (..+) \g1+ $ (?{ $sum += length $1 }) ./xg;
  return $sum
}

sub has_amicable {
  my $start = shift;
  my $pair = sum_of_proper_divisors($start);
  #sometimes the sum of the divisors IS the number. But that's not amicable
  return 0 if $pair == $start;
  return $start == sum_of_proper_divisors $pair;
}


my $num;
while (1) {
  last if has_amicable(++$num);
}

say "$num, ${\sum_of_proper_divisors($num)} is your pair"
