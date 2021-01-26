#!/usr/bin/perl

# Challenge 010
#
# Challenge #1
# Write a script to encode/decode Roman numerals. For example, given Roman
# numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it
# should return XXXIX. Checkout wikipedia page for more information.

use strict;
use warnings;
use 5.030;

my %ROMAN = ( M => 1000, D => 500, C => 100, L => 50, X => 10, V => 5, I => 1 );
my $RE = qr/[MDCLXVI]/i;

sub decode_roman {
    my($str) = @_;
    my $num = 0;
    while ($str ne '') {
        for ($str) {
            if (/^($RE)($RE)(.*)/i && $ROMAN{$1} < $ROMAN{$2}) {
                $num += $ROMAN{uc($2)} - $ROMAN{uc($1)};
                $_ = $3;
            }
            elsif (s/^(($RE)\1*)//i) {
                $num += $ROMAN{uc($2)}*length($1);
            }
            else {
                die "cannot parse: $_\n";
            }
        }
    }
    return $num;
}

sub encode_roman {
    my($num) = @_;
    my $str = "";
    while ($num > 0) {
        if ($num >= 1000) { $str .= "M" x int($num/1000); $num %= 1000; }
        elsif ($num >= 900) { $str .= "CM"; $num -= 900; }
        elsif ($num >= 500) { $str .= "D"; $num -= 500; }
        elsif ($num >= 400) { $str .= "CD"; $num -= 400; }
        elsif ($num >= 100) { $str .= "C" x int($num/100); $num %= 100; }
        elsif ($num >= 90) { $str .= "XC"; $num -= 90; }
        elsif ($num >= 50) { $str .= "L"; $num -= 50; }
        elsif ($num >= 40) { $str .= "XL"; $num -= 40; }
        elsif ($num >= 10) { $str .= "X" x int($num/10); $num %= 10; }
        elsif ($num >= 9) { $str .= "IX"; $num -= 9; }
        elsif ($num >= 5) { $str .= "V"; $num -= 5; }
        elsif ($num >= 4) { $str .= "IV"; $num -= 4; }
        elsif ($num >= 1) { $str .= "I" x $num; $num = 0; }
        else { die; }
    }
    return $str;
}

for (@ARGV) {
    if (/-test/) {
        for (1..3000) {
            my $str = encode_roman($_);
            my $num = decode_roman($str);
            $_ == $num or die "$_ => $str => $num";
        }
    }
    elsif (/^\d+/) {
        say "$_ => ", encode_roman($_);
    }
    else {
        say "$_ => ", decode_roman($_);
    }
}
