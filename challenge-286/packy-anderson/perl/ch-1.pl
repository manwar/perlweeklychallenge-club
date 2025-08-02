#!/usr/bin/env perl
use v5.40;

my @words;
open my $fh, '<', __FILE__;
while (my $line = <$fh>) {
  push @words, grep { length($_) } split /\s+/, $line;
}
close $fh;

say $words[ int(rand($#words + 1)) ];
