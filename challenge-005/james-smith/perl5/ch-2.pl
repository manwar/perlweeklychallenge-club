use strict;
use warnings;
use feature qw(say);

## Read in letters from command line... and store in signature
my %ds;
my $max = 0;

## Loop 1 - read all the words in - skip any that are
foreach (<>) {
  chomp;
  next if m{[^a-z]};
  my $kw = signature($_);
  push @{$ds{$kw}}, $_;
  $max = @{$ds{$kw}} if @{$ds{$kw}} > $max;
}

## Loop2 - loop through all the words and
printf "%3d %-12s %s\n", $max, $_, "@{[ sort @{$ds{$_}} ]}" for
  sort
  grep { @{$ds{$_}} == $max }
  keys %ds;
say '';

## Signature algorithm - remove non alpha characters, lc,
## split and sort....

sub signature {
  return join q(), sort split //, $_[0];
}

