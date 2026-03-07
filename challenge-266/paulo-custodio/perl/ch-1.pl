#!/usr/bin/env perl

use Modern::Perl;

my($line1, $line2) = split /,/, "@ARGV";
my %count;
for my $word (split ' ', "$line1 $line2") {
    $count{$word}++;
}
my @uncommon = sort grep {$count{$_}==1} keys %count;

say "(", join(", ", @uncommon), ")";
