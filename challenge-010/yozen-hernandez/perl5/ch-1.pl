#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use feature 'say';
use constant MAX_INT => 3999;

# Write a script to encode/decode Roman numerals.
# For example, given Roman numeral CCXLVI, it should return 246.
# Similarly, for decimal number 39, it should return XXXIX.

# https://stackoverflow.com/a/267405/876844
my $valid_roman
    = qr/^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/;

my %roman_vals = (
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000,
);

my %val_to_roman = (
    1    => 'I',
    4    => 'IV',
    5    => 'V',
    9    => 'IX',
    10   => 'X',
    40   => 'XL',
    50   => 'L',
    90   => 'XC',
    100  => 'C',
    400  => 'CD',
    500  => 'D',
    900  => 'CM',
    1000 => 'M',
);

sub roman_to_int {
    my $roman = shift;

    # Won't happen with the way this script is coded
    return 0 if $roman eq "";
    croak "Error: Invalid Roman numeral.\n" unless $roman =~ $valid_roman;
    my @roman_arr = split //, $roman;

    my $decoded = 0;
    my $val;

    # Traverse string from left to right.
    # Assume subtractive notation and increment while
    # the value is the same or decreasing. Subtract
    # from current if value increases.
    # Assumes regex above allows only valid numerals
    for ( my $r = 0; $r < @roman_arr; ) {
        my $curr = $roman_arr[$r];
        $val = $roman_vals{ $roman_arr[$r] };

        # Consume all of the same value, adding along the way
        while ( ++$r < @roman_arr && $curr eq $roman_arr[$r] ) {
            $val += $roman_vals{ $roman_arr[$r] };
        }

        # If there's still more of the array, and the next
        # value is greater than that of the current symbol,
        # subtract value of current symbol. That is the new
        # current value.
        # This actually ignores the "extra" symbols in something
        # like IIIX, which would be considered invalid anyway.
        if (   $r < @roman_arr
            && $roman_vals{$curr} < $roman_vals{ $roman_arr[$r] } )
        {
            $val = $roman_vals{ $roman_arr[$r] } - $roman_vals{$curr};
            ++$r;
        }

        $decoded += $val;
    }

    return $decoded;
}

sub int_to_roman {
    my $int = shift;
    croak "Error: Integer exceeds maximum representable value."
        if $int > MAX_INT;

    my $str;
    for my $val ( sort ( { $b <=> $a } keys %val_to_roman ) ) {

        # Must find the largest numeral which can be subtracted
        while ( $val <= $int ) {
            $int -= $val;
            $str .= $val_to_roman{$val};
        }
    }

    return $str;
}

my $rm_num = shift or die "Usage: $0 <roman numeral>\n";
my $to_int = roman_to_int($rm_num);
say "$rm_num = $to_int";
my $to_rm = int_to_roman($to_int);
say "$to_int = $to_rm";

if ( $rm_num eq $to_rm ) {
    say "Hey, it worked!";
}
else {
    say "Something's definitely wrong...";
}
