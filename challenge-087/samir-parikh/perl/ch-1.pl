#!/usr/local/bin/perl

use warnings;
use strict;
use feature 'say';

# run program as:
# $ ./ch-1.pl "100, 4, 50, 3, 2"
my @input = split /, /, $ARGV[0];
my $longestSequenceLength = 0;
my @longestSequence;

foreach my $i (@input) {
    my @currentSequence;
    push (@currentSequence, $i);
    my $currentSequenceLength = 1;
    my $checkFor = $i + 1;
    while ( grep( $_ eq $checkFor, @input ) ) {
        $currentSequenceLength++;
        push (@currentSequence, $checkFor);
        $checkFor++;
    }
    if ($currentSequenceLength > $longestSequenceLength) {
        $longestSequenceLength = $currentSequenceLength;
        @longestSequence = @currentSequence;
    }
}

print "Output: ";
if ($longestSequenceLength > 1) {
    say "(", join(", ", @longestSequence), ")";
} else {
    say 0;
}
