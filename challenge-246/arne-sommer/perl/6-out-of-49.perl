#! /usr/bin/env perl

my %six;

while (keys %six < 6)
{
  $six{ int(1+ rand(48)) } = 1;
}

foreach my $key (sort { $a <=> $b } keys %six)
{
  print "$key\n";
}
