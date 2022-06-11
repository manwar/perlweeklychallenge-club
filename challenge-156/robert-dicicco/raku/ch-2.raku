use v6;

use Prime::Factor;

# Author: Robert DiCicco
# Date15-MAR-2022
# Challenge 156 Weird Numbers ( Raku )

sub digitsum ( @arr ) {             # sum the elements of an array
  my $sum = 0;
  for @arr {
     $sum += $_;
  }

  return $sum
}

sub MAIN(Int $num) {
  my @divs = divisors $num;         # get divisors for the given number
  @divs.pop;                        # get rid of the last element

  say "Divisors: " ~ @divs;
  my @dc = @divs.combinations;      # get all multi-length combinations of divisors
  my $flag = 0;

  for @dc -> @partial {
    my $sum = digitsum(@partial);   # send it to be summed

    if ($sum == $num) {             # print this stuff if the combination = to requested number
      say "Subset: " ~ @partial;
      say "Input: n = $num";
      say "Output: 0";
      say " ";

      $flag++;
      last;
    }
  }

  if $flag == 0 {                   # print this stuff if no combination = to requested number
    say "Input: n = $num";
    say "Output: 1";
    say "No subset sums to $num";
  }
}
