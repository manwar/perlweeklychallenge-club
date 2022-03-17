use strict;
use warnings;
use 5.30.0;

# Author: Robert DiCicco
# Date: 7-MAR-2022
# Challenge #155 Pisano Period ( Perl )

my @fibs = (0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765,);
my @out;  # array to hold output
my $MODULO = 3;

### Got this REGEX from Perl Monks website - written by Damian Conway

my $REPETITION_PAT = qr{
  \A         # Start at the beginning of the string
  (.+?)      # Match minimal initial sequence (as $1)
  \1*+       # Rematch it exactly as often as possible (maybe zero)

  # Then verify what's left is a proper truncation...
  (?(?{ index($^N, substr($_,pos())) }) (?!) )

}xms;

my $str = ();
foreach my $elem (@fibs) {     # for each
  push(@out, $elem % $MODULO);
  $str .= ($elem % $MODULO);
}

print "Fib Sequence: @fibs\n";

for my $i (1..length($str)) {
  my $s = substr($str,0,-$i);
  if ($s =~ $REPETITION_PAT) {
      say "Mod Sequence: $s\n     Matched: $1";
    say "      Period: " . length($1) . "\n";
    last;
  }
  else {
    say "$s\n     Didn't match";
  }
}
