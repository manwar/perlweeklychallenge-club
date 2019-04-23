use strict;
use warnings;
use feature qw(say);

## Read in letters from command line... and store in signature

my %ds;
my $max = 5; ## mates/meats/steam/teams/tames has at least 5 so we will use this as a base!

my %maxkeys; ## We keep a copy of the max keys so we don't need to do the big grep later!

## Loop 1 - read all the words in - skip any that are
foreach (<>) {
  chomp;
  next if m{[^a-zA-Z]};
  my $kw = join q(), sort split //, lc $_;
  $ds{$kw}{lc $_} = $_;                ## Removes duplicates with differing capitalization!
  my $t = keys %{$ds{$kw}};
  next if $t < $max;
  ($max,%maxkeys) = ($t) if $t > $max; ## reset hash keys....
  $maxkeys{$kw}=1;                     ## $kw could appear multiple times so we need to
                                       ## keep this unique!
}

## Now we dump the results out - we loop through maxkeys array - saves the big grep loop
## from previous!
printf "%3d %-12s %s\n", $max, $_, "@{[sort { lc $a cmp lc $b } values %{$ds{$_}}]}" for
  sort
  keys %maxkeys;
say '';

