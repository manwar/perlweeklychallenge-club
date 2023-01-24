sub pile-pennies (UInt:D $n) {
  # repeat elements to treat the problem as a combination with repetition
  my @elements-with-repetition = (1..$n).map({ $_ xx $n }).flat;

  for @elements-with-repetition
    .combinations(1..$n)
    .grep(*.sum == $n)
    .unique(:with(&infix:<eqv>))
    .reverse -> @row
  {
    say @row.join: ' ';
  }
}

pile-pennies 5;
print "\n";
pile-pennies 6;
