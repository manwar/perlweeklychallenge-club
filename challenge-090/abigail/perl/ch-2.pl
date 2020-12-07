#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
#   Given two positive numbers $A and $B, demonstrate "Ethiopian
#   Multiplication", using the given numbers.
#

#
# "Ethiopian Multiplication" or "Ancient Egyption Multiplication"
# is nothing more than multiplication in binary.
#

my $TICK = "\N{CHECK MARK}";

binmode STDOUT, ":utf8";

while (<>) {
    use integer;
    my ($A, $B) = /([0-9]+) \s+ ([0-9]+)/x or next;
    my $w1 = length $A;
    my $w2 = length (my $product = $A * $B);
    while ($A) {
        printf "%${w1}d  %${w2}d %s\n" => $A, $B, $A % 2 ? $TICK : "";
        $A /= 2;
        $B *= 2;
    }
    say " " x $w1, "  ", "-" x $w2, " +";
    say " " x $w1, "  ", $product;
}


__END__
