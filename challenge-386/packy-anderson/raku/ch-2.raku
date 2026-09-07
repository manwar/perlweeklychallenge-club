#!/usr/bin/env raku
use v6;

sub rationalToFraction($rat is copy) {
  my ($int, $nr, $rep) = ($rat ~~ /(\d*)\.(\d*)?[\((\d*)\)]?/).list;
  $nr  ||= 0; # if no non-repeating digits, use 0 in addition
  $rep ||= 0; # if no repeating digits, use 0 in addition
  my $pow1  = $nr  ?? 10 ** $nr.chars        !! 1;
  my $pow2  = $rep ?? 10 ** ($rep.chars) - 1 !! 1;
  my $num   = ($int * $pow1 + $nr) * $pow2 + $rep;
  my $denom = $pow2 * $pow1;
  my $d     = $num gcd $denom;
  ($num / $d, $denom / $d);
}

sub rationalEqual($rat1, $rat2) {
  my ($n1, $d1) = rationalToFraction($rat1);
  my ($n2, $d2) = rationalToFraction($rat2);
  my $len = max($rat1.chars, $rat2.chars);
  return (
    $n1 == $n2 && $d1 == $d2 ?? 'true' !! 'false',
    sprintf("%*s is %d/%d\n%*s is %d/%d",
            $len, $rat1, $n1, $d1,
            $len, $rat2, $n2, $d2)
  );
}

sub solution($rat1, $rat2) {
  say qq/Input: \$rat1 = "$rat1"/;
  say qq/       \$rat2 = "$rat2"/;
  my ($output, $explain) = rationalEqual($rat1, $rat2);
  say qq/Output: $output\n\n$explain/;
}

say "Example 1:";
solution("0.(12)", "0.(121)");

say "\nExample 2:";
solution("0.1(23)", "0.12(32)");

say "\nExample 3:";
solution("0.1(234)", "0.12(342)");

say "\nExample 4:";
solution("12.99(99)", "13.");

say "\nExample 5:";
solution("0.(123)", "0.1(231)");
