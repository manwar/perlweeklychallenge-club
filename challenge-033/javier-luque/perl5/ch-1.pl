#!/usr/bin/perl
# Test: ./ch1.pl example1.txt example2.txt
use strict;
use warnings;
binmode STDOUT, ':utf8';
my %counts;

# Loop through each file
for my $file (@ARGV) {
    open my $fh, "<:encoding(UTF-8)", $file or die "$file: $! \n";

    # Increment count for each word char
    while (my $char = getc($fh)) {
        $counts{lc($char)}++ if (lc($char) =~ /[\w]/);
    }
}

# Print each char and count
for my $char (sort keys %counts) {
    printf("%2s %5i\n", $char, $counts{$char});
}
