use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-04
# Challenge 172 Prime Partition ( Raku )

my @arr = ();                             # result array

sub MAIN( Int $m, Int $n ) {              # $n = number to test, $n = how many factors to sum
  for 1..$m -> $p {
    if ($p.is-prime) { @arr.push: $p }
  }

  for @arr.combinations($n) {             # for each combination of size $n
    if $_.sum == $m {                     # print if sum = $m
      say $_;
    }
  }
}
