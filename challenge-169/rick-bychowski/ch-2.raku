#!/usr/bin/env raku

# Achilles Numbers
sub MAIN(Int $limit = 20 ) {
#    say is-achilles($limit);
    my $i;
    my @achilles-numbers;
    for 4 .. * -> $n {
        if is-achilles($n) {
            @achilles-numbers.push($n);
            $i++;
            last if $i == $limit;
        }
    }
    say @achilles-numbers.join(", "); 
}

# Given Integer, Return True if Achilles
sub is-achilles( Int $n where $n > 0 ) {
    my %f = factor($n);
    if %f and %f.values.all > 1 {
        my $min = %f.values.min;
        return True unless %f.values.all %% $min;
    }
    return False;
}

# Input: Positive Integer
# return all prime factors as a HoH:
#   factor($dividend)   # { $factor1 => $power1, $factor2 => $power2, ... }
#   Example: factor(24) # { 24 => { 2 => 3, 3 => 1 } }
sub factor($dividend = 2, %factors?) {
    my %f = %factors ?? %factors !! ();
    my $quotient;
    if $dividend.is-prime {
        %f{$dividend}++;
        return %f;
    }
    for 2 ..^ $dividend -> $i {
        if $dividend %% $i {
            $quotient = Int($dividend / $i);
            %f{$i}++;
            if $quotient.is-prime {
                %f{$quotient}++;
                return %f;
            } else {
                return factor($quotient, %f);
            }
        }
    }
}

=begin comment
Write a script to generate first 20 Achilles Numbers. Please checkout wikipedia
for more information.

    An Achilles number is a number that is powerful but imperfect (not a
	perfect power). Named after Achilles, a hero of the Trojan war, who was
	also powerful but imperfect.

    A positive integer n is a powerful number if, for every prime factor p of n,
	p^2 is also a divisor.

    A number is a perfect power if it has any integer roots
	(square root, cube root, etc.).

For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also has
	its square as a divisor (4, 9). But 36 has an integer square root, 6,
	so the number is a perfect power.

But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as divisors, but
	it has no integer roots. This is an Achilles number.

Output

 72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972, 1125,
	1152, 1323, 1352, 1372, 1568, 1800
=end comment
