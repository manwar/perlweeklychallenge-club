use strict;
use warnings;
use feature qw(say);
use Time::HiRes qw(time);

## Read in letters from command line... and store in signature
my $t0 = time;
my %ds;
my $max = 0;

## Loop 1 - read all the words in - skip any that are
foreach (<>) {
  chomp;
  next if m{[^a-zA-Z]};
  my $kw = signature($_);
  $ds{$kw}{lc $_} = $_; ## Removes duplicates with differing capitalization!
  $max = keys %{$ds{$kw}} if keys %{$ds{$kw}} > $max;
}

my $t1 = time;
printf "%3d %-12s %s\n", $max, $_, "@{[sort { lc $a cmp lc $b } values %{$ds{$_}}]}" for
  sort
  grep { keys %{$ds{$_}} == $max }
  keys %ds;
say '';

my $t2 = time;

say 'Loop 1: ', $t1-$t0, '; loop 2: ', $t2-$t1;

## Signature algorithm - remove non alpha characters, lc,
## split and sort....

sub signature {
  return join q(), sort split //, lc $_[0];
}

