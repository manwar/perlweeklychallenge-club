#!/usr/bin/env raku
use v6;

sub findPrimeFactors(Int $number) {
  my @factors;
  my $num = $number;
  while ( $num % 2 == 0 ) {
    @factors.push(2);
    $num /= 2;
  }
  for 3 .. sqrt($num).Int -> $i {
    while ( $num % $i == 0 ) {
      @factors.push($i);
      $num /= $i;
    }
  }
  if ($num > 2) {
    @factors.push($num);
  }
  return @factors;
}

sub sortByPrimeFactors(@int) {
  my %primeFactors;
  # calculate the prime factors for each number
  for @int -> $n {
    %primeFactors{$n} = findPrimeFactors($n);
  }
  # now sort the numbers
  my @sorted = @int.sort({
    # first, sort by number of factors
    %primeFactors{$^a} <=> %primeFactors{$^b}
    ||
    # then sort by the value of the factors
    listCompare(%primeFactors{$^a}, %primeFactors{$^b})
  });
  # now build the output
  my $factors = q{};
  for @sorted -> $n {
    $factors ~= sprintf 'Prime factors of %2d => ', $n;
    $factors ~= %primeFactors{$n}.join(', ') ~ "\n";
  }
  return @sorted, $factors;
}

sub listCompare(@a, @b) {
  # this is only getting called if both lists
  # have the same number of elements
  my $i = 0;

  # compare the corresponding element from each
  # list until they're unequal
  while ($i < @a.elems && @a[$i] == @b[$i]) {
    $i++;
  }
  # if we ran off the end of the list, set $i to 0
  $i = 0 if $i >= @a.elems;

  return @a[$i] <=> @b[$i];
}

sub solution(@int) {
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  my ($sorted, $factors) = sortByPrimeFactors(@int);
  say 'Output: (' ~ $sorted.join(', ') ~ ')';
  say '';
  say $factors;
}

say "Example 1:";
solution([11, 8, 27, 4]);

say "Example 2:";
solution([2, 4, 8, 12, 11]);