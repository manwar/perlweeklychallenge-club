#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


sub line_counts {
    my ($str, @widths) = @_;

    my $max_width = 100;
    my $current_width = 0;
    my $lines = 1;

    foreach my $char (split //, $str) {
        my $char_width = $widths[ord($char) - ord('a')];
        if ($current_width + $char_width > $max_width) {
            $lines++;
            $current_width = $char_width;
        } else {
            $current_width += $char_width;
        }
    }

    return ($lines, $current_width);
}

# Test cases
use Test::More;

is_deeply([line_counts("abcdefghijklmnopqrstuvwxyz", (10) x 26)], [3, 60], 'Example 1');
is_deeply([line_counts("bbbcccdddaaa", (4, 10, (10) x 24))], [2, 4], 'Example 2');

done_testing();

# Print results for visualization
print "Output Example 1: ", join(", ", line_counts("abcdefghijklmnopqrstuvwxyz", (10) x 26)), "\n";
print "Output Example 2: ", join(", ", line_counts("bbbcccdddaaa", (4, 10, (10) x 24))), "\n";
