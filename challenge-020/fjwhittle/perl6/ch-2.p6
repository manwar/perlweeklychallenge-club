#!/usr/bin/env perl6

use experimental :cached;

sub proper-divisor-sum(Int $n --> Int) is cached {
  [+] (1, |(2..($n.sqrt)).race.map: -> $m {
	  |($n %% $m ?? ($m, Int($n / $m)) !! ())
	}).unique
}

# Euler version; somewhat disappointing density of results, but produces the
# first pair instantly.
#| Generate <count> amicable number pairs.
multi MAIN(
  $count = 1,             #= Generate this many numbers; defaults to 1.
  Bool :$euler where *.so #= Use an Euler generation instead of filtering out
                          #= non-amicable pairs; sparse results (1st, 8th, ...)
) {
  my @amicable = lazy gather for hyper 1^..Inf -> $n {
    for hyper 0^..^$n -> $m {
      my $prefix := (2 ** ($n - $m) + 1);
      my $p = $prefix      * 2 **  $m       - 1;
      my $q = $prefix      * 2 **  $n       - 1;
      my $r = $prefix ** 2 * 2 ** ($m + $n) - 1;

      take (2 ** $n * $p * $q) => (2 ** $n * $r)
        if all($p, $q, $r).is-prime
    }
  }

  @amicable[^$count]».fmt('%d, %d')».put
};

# Naive version, that produces many more results.
multi MAIN($count = 1, :$no-euler) is hidden-from-USAGE {
  my SetHash $ak;
  
  my @amicable = lazy (1..Inf).hyper.map(-> $n { $n => proper-divisor-sum($n) })
    .grep({ !$ak{.key}
  	    and .key != .value
            and proper-divisor-sum(.value) == .key
  	    and $ak{.key, .value}»++
          });

  @amicable[^$count]».fmt('%d, %d')».put
}
