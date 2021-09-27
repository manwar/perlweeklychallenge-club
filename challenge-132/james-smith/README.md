# Perl Weekly Challenge #132

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-132/james-smith/perl

# Task 1 - Mirror dates

***You are given a date (yyyy/mm/dd). Assuming, the given date is your date of birth. Write a script to find the mirror dates of the given date.***

## The solution

 
```perl
my @TODAY = @ARGV ? split m{/}, $ARGV[0]: Today;

sub mirror_days {
  my $d = Delta_Days( @TODAY, split m{/}, $_->[0] );
  return  [
    sprintf( '%04d/%02d/%02d', Add_Delta_Days( @bd,     $d )),
    sprintf( '%04d/%02d/%02d', Add_Delta_Days( @TODAY, -$d )),
  ];
}
```

# Task 2 - Hash join

***Write a script to implement Hash Join algorithm as suggested by wikipedia.***

 * For each tuple r in the build input R
   * Add r to the in-memory hash table
   * If the size of the hash table equals the maximum in-memory size:
     * Scan the probe input S, and add matching join tuples to the output relation
     * Reset the hash table, and continue scanning the build input R
 * Do a final scan of the probe input S and add the resulting join tuples to the output relation


## Solution


```perl
my $MAX = @ARGV ? $ARGV[0] : 4;
my @res;

while( my @pns = splice @player_names, 0, $MAX ) {
  my %cache = ();
  push @{$cache{$_->[0]}},$_->[1] foreach @pns;
  foreach my $p (@player_ages) {
    push @res, [$p->[0], $p->[1], $_] foreach @{$cache{$p->[1]}};
  }
}

printf "%4d\t%-20s\t%-20s\n", @{$_} foreach @res;
```
