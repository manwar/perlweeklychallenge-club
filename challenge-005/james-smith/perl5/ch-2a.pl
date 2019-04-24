use strict;
use warnings;
use feature qw(say);

## Read in letters from command line... and store in signature
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

printf "%3d %-12s %s\n", $max, $_, "@{[sort { lc $a cmp lc $b } values %{$ds{$_}}]}" for
  sort
  grep { keys %{$ds{$_}} == $max }
  keys %ds;
say '';

## Signature algorithm - remove non alpha characters, lc,
## split and sort....

sub signature {
  return join q(), sort split //, lc $_[0];
}

