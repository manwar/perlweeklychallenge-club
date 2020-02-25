#!/usr/bin/env perl6

# ch-2.p6 - Palindrome Dates (mm/dd/yyyy)
#
# Ryan Thompson <rjt@cpan.org>

for (<02 12 22> X (1..12)».fmt('%02d')».flip.sort).flat -> $dd, $yy {
    say "{$yy.flip}-$dd-{$dd.flip}$yy";
}

# Naive method
#.say for (2000..2999).map({ $_.flip.comb(2), $_ }).flat.grep: &valid-date;

#| Return True if a mmddyyyy date is valid
#  This won't work in general; it works here because of the range (see blog)
#sub valid-date( $m, $d, $y ) {  1 ≤ $m ≤ 12 and 1 ≤ $d ≤ 31; }
