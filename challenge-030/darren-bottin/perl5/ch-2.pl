#!perl
use strict;
use warnings;

my %solutions;
for my $foo (1..10) {
  for my $bar ($foo+1..11-$foo) {
    my $baz = 12 - $foo - $bar;
    my @sorted = sort ($foo, $bar, $baz);
    my $asoln = join ("\+", @sorted);
    $solutions{$asoln}++;
  }
}
print "$_ = 12\n" foreach sort keys %solutions;
