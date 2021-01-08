#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper::OneLine;

# Input
my @words = ("opt", "bat", "saw", "tab", "pot", "top", "was");

# Group Anagrams
my %groups = ();

for my $word (@words) {
  my $sortedWord = join "", sort split //, $word;

  $groups{$sortedWord} = [] if(!defined $groups{$sortedWord});

  push @{$groups{$sortedWord}}, $word;
}

# Output
print Dumper($_) for (values %groups);