#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

# Create @L
my @L = sort { $a <=> $b } map { int(rand(50) + 1) } ( 1 .. 50 );
my $i = 0;
my $total = scalar(@L);

# Output the list
say "List: " . join ', ', @L;

# Loop through each number
while ($i < $total) {
    # Skip duplicates
    if ($i + 1 < $total && $L[$i] != $L[$i + 1]) {
        say "Noble number found: " . $L[$i]
            if ($L[$i] == $total - $i - 1);
    }
    $i++;
}
