#!/usr/bin/perl
use strict;
use warnings;

my %seen;

while (<DATA>) {
    chomp;
    $seen{$_}++;
}

my $csv = defined $ARGV[0] && $ARGV[0] eq '-csv';

foreach my $fruit (sort { $seen{$b} <=> $seen{$a} } keys %seen) {
    $csv
        ? print("$fruit,$seen{$fruit}\n")
        : printf("%-10s %d\n", $fruit, $seen{$fruit});
}

# Output:
# apple     3
# cherry    2
# banana    1

# Output with -csv option:

# apple,3
# cherry,2
# banana,1

__DATA__
apple
banana
apple
cherry
cherry
apple
