#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    chomp $line;
    my @words = split /\s+/ => $line;
    my @diffs = map {
        #
        # Shift each letter with the same amount, such that 
        # each word starts with 'a'
        #
        my $offset = ord (substr ($_, 0, 1)) - ord ('a');
        join "" => map {chr (ord ($_) - $offset)} split //;
    } @words;

    #
    # Find the diff which is the odd one out. It's odd if it
    # differs from both the next, and previous diff, where @diffs
    # is treated as a cycle.
    #
    foreach my $index (keys @diffs) {
        if ($diffs [$index] ne $diffs [($index + 1) % @diffs] &&
            $diffs [$index] ne $diffs [ $index - 1]) {
            say $words [$index];
            last;
        }
    }
}


__END__
