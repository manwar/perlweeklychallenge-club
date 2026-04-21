#!/usr/bin/perl
use strict;
use warnings;

sub jumping_letters {
    # $word = input string (e.g. "ybcd")
    # $steps = array reference (one number per character in the text)
    my ($word, $steps) = @_;

    # Check that text and steps have the same length
    if (length($word) != @$steps) {
        die "Error: word length and steps length must be equal\n";
    }

    # Check that text contains only letters (A–Z, a–z)
    if ($word !~ /^[A-Za-z]+$/) {
        die "Error: text must contain only letters (A–Z, a–z)\n";
    }

    # Split the string into individual characters
    my @chars = split //, $word;

    # This will store the final transformed string
    my $result = '';

    # Loop over each character position
    for my $i (0 .. $#chars) {

        # Get the current character from the input string
        my $char = $chars[$i];

        # ASCII codes:
        # 'A' = 65–90, 'a' = 97–122
        # Uppercase letters have LOWER codes than lowercase letters.
        my $base = ($char le 'Z') ? ord('A') : ord('a');

        # Get the step value from the input array (matches this character position)
        my $step = $steps->[$i];

        # Step 1: convert letter to position in alphabet (0–25)
        # Example: 'y' -> 121 - 97 = 24
        my $pos = ord($char) - $base;

        # Step 2: move forward by the given step
        # Example: 24 + 3 = 27
        $pos += $step;

        # Step 3: wrap around the alphabet (26 letters)
        # Example: 27 % 26 = 1 -> wrapped back to start
        $pos %= 26;

        # Step 4: convert position back to a letter
        # Example: 1 + 97 = 98 -> 'b'
        my $shifted = chr($pos + $base);

        # So: 'y' with step 3 becomes 'b'

        # Add the transformed character to the result
        $result .= $shifted;
    }

    # Return the final transformed string
    return $result;
}

# Tests

my $word;
my @jump;

# Example 1
$word = 'Perl';
@jump = (2,22,19,9);
print jumping_letters($word, \@jump), "\n"; # Output: Raku

# Example 2
$word = 'Raku';
@jump = (24,4,7,17);
print jumping_letters($word, \@jump), "\n"; # Output: Perl

# Example 3
$word = "ybcd";
@jump = (3, 2, 3, 4);
print jumping_letters($word, \@jump), "\n"; # Output: bdfh
