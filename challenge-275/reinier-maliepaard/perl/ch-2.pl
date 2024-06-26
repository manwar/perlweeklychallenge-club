#!/usr/bin/perl
use strict;
use warnings;

sub replace_digits {

    my ($result, $prev_char);

    foreach my $char (split(//, $_[0])) {

        ($char =~ /[a-z]/i) ? ( $result .= $prev_char = $char )
                            : ( $result .= chr( ord($prev_char) + $char ) );

    }
    print ($result, "\n");
}

# Tests

my $str;

# Example 1
$str = "a1c1e1";
replace_digits($str); # Output: 'abcdef'

# Example 2
$str = "a1b2c3d4";
replace_digits($str); # Output: 'abbdcfdh'

# Example 3
$str = "b2b";
replace_digits($str); # Output: 'bdb'

# Example 4
$str = "a16z";
replace_digits($str); # Output: 'abgz'

# Example 5
$str = "a1234f";
replace_digits($str); # Output: 'abcdef'

# Example 6
$str = "A1234F";
replace_digits($str); # Output: 'ABCDEF'

#Example 7 (test example from Niels van Dijke)
$str = "Z5";
replace_digits($str); # Output: 'Z_'
