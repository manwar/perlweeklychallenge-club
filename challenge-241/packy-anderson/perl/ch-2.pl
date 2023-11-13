#!/usr/bin/env perl
use v5.38;

sub findPrimeFactors {
  my $num = shift;
  my @factors;
  while ( $num % 2 == 0 ) {
    push @factors, 2;
    $num /= 2;
  }
  foreach my $i ( 3 .. int(sqrt($num)) ) {
    while ( $num % $i == 0 ) {
      push @factors, $i;
      $num /= $i;
    }
  }
  if ($num > 2) {
    push @factors, $num;
  }
  return @factors;
}

sub sortByPrimeFactors {
  my @int = @_;
  my %primeFactors;
  # calculate the prime factors for each number
  foreach my $n ( @int ) {
    $primeFactors{$n} = [ findPrimeFactors($n) ];
  }
  # now sort the numbers
  my @sorted = sort {
    # first, sort by number of factors
    $#{$primeFactors{$a}} <=> $#{$primeFactors{$b}}
    ||
    # then sort by the value of the factors
    listCompare($primeFactors{$a}, $primeFactors{$b})
  } @int;
  # now build the output
  my $factors = q{};
  foreach my $n ( @sorted ) {
    $factors .= sprintf 'Prime factors of %2d => ', $n;
    $factors .= join(', ', @{$primeFactors{$n}}) . "\n";
  }
  return \@sorted, $factors;
}

sub listCompare($a, $b) {
  # this is only getting called if both lists
  # have the same number of elements
  my $i = 0;

  # compare the corresponding element from each
  # list until they're unequal
  while ($i <= $#{$a} && $a->[$i] == $b->[$i]) {
    $i++;
  }
  # if we ran off the end of the list, set $i to 0
  $i = 0 if $i > $#{$a};

  return $a->[$i] <=> $b->[$i];
}

sub solution(@int) {
  say 'Input: @int = (' . join(', ', @int) . ')';
  my ($sorted, $factors) = sortByPrimeFactors(@int);
  say 'Output: (' . join(', ', @$sorted) . ')';
  say '';
  say $factors;
}

say "Example 1:";
solution(11, 8, 27, 4);

say "Example 2:";
solution(2, 4, 8, 12, 11);