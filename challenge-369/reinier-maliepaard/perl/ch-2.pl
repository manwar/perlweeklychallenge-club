#!/usr/bin/perl
use strict;
use warnings;

# Several solutions are possible here. I choose for a simple loop solution
# with the marvelous substr!
# see: https://reiniermaliepaard.nl/perl/part-6/index.php?id=substr
# see also: https://reiniermaliepaard.nl/pwc/index.php?id=pwc045-1

sub group_division {
    my ($str, $size, $filler) = @_;
    my @parts;

    # Keep looping as long as there is still text left in $str
    while (length($str) > 0) {
        # Take the first $size characters from $str
         # substr(..., '',) also REMOVES that part from $str
        my $chunk = substr($str, 0, $size, '');
        if (length($chunk) < $size) {
            # Add filler characters to make it exactly $size long
              # ($size - length($chunk)) = how many characters we still need
            $chunk .= $filler x ($size - length($chunk));
        }
        push @parts, $chunk;
    }

    return @parts;
}


# Tests

# Example 1
print '(' . join(',', map { '"' . $_ . '"' } group_division("RakuPerl", 4, "*")) . ')', "\n"; # Output: ("Raku", "Perl")

# Example 2
print '(' . join(',', map { '"' . $_ . '"' } group_division("Python", 5, "0")) . ')', "\n"; # Output: ("Pytho", "n0000")

# Example 3
print '(' . join(',', map { '"' . $_ . '"' } group_division("12345", 3, "x")) . ')', "\n"; # Output: ("123", "45x")

# Example 4
print '(' . join(',', map { '"' . $_ . '"' } group_division("HelloWorld", 3, "_")) . ')', "\n"; # Output: ("Hel", "loW", "orl", "d__")

# Example 5
print '(' . join(',', map { '"' . $_ . '"' } group_division("AI", 5, "!")) . ')', "\n"; # Output: ("AI!!!")
