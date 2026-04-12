#!/usr/bin/perl
use strict;
use warnings;

sub square_secret_code {

    my ($input) = @_;

    # 1) Remove all horizontal whitespace (spaces, tabs, etc.)
    $input =~ s/\h+//g;

    # 2) Split into chunks of up to 8 characters.
    #    IMPORTANT: last chunk is preserved even if shorter
    my @chunks = ($input =~ /.{1,8}/g);

    # 3) Build column-wise accumulation array
    #    Each column collects the nth character of every chunk.
    my @columns;

    for my $chunk (@chunks) {

        # Iterate over each character position in the chunk
        for my $i (0 .. length($chunk) - 1) {
            $columns[$i] .= substr($chunk, $i, 1);
        }
    }

    return @columns;
}

# Tests

my $S;

# Example 1:
$S = "    the quick brown fox jumps over the lazy dog   ";
print join(' ',square_secret_code($S)), "\n"; # Output: tbjrd hruto eomhg qwpe unsl ifoa covz kxey
