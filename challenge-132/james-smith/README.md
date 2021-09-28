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

Here we use Date::Calc module to handle the date time manipulations.

We compute the number of days between dob & today. We then work out which day is this distance before the dob & after today to give the two values.
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

The problem is "simple" seems simple to begin with - but there are two "gotchas"..

 * We have to chunk the first array up into chunks of no more than `$N`.
 * The keys in the two tables are NOT unique, so we need to store multiple values based on a key;
 
To solve the first problem we break the input array up into to chunks of size `$MAX`, and repeat foreach one.

To resolve the issue of the multiple keys, instead of the value of the cache being the value itself, it is the key to an array of values.

Although not needed - the code is written to match the description above - so works with multiple non key columns in both tables.

```perl

## index of key columns...
my $ages_key      = 1;
my $names_key     = 0;

## Get non-key columns in the names table... 
##   { get all column ids and splice out the key column}
my @names_columns = 0..(@{$player_names[0]}-1); 
splice @names_columns, $names_key,1; ## Remove key....

## Get chunk size (default to 4)
my $MAX = @ARGV ? $ARGV[0] : 4;

my @res;

while( my @pns = splice @player_names, 0, $MAX ) {
  my %cache = ();
  ## Foreach we key on the key column, and store the non-key columns
  ##   Because key columns not unique we have array of arrays for
  ##   the hash values
  push @{$cache{$_->[$names_key]}},[ @{$_}[@names_columns] ] foreach @pns;

  ## Now loop through the array of ages.
  ## When we find a key we dump all values.
  ## We push all values in the ages table - and all values (except the key) of the names table
  foreach my $p (@player_ages) {
    push @res, [@{$p}, @{$_}] foreach @{$cache{$p->[$ages_key]}};
  }
}

## Just print values
say join "\t", map { sprintf '%-15s', $_ } @{$_} foreach @res;
```
