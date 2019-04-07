# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y.

use v5.10;
use strict;
use warnings;

my @glyphs = (0..9, 'A'..'Y');

sub to_base35 {
    my $num = shift;
    my $res = "";
	do {
        $res .= $glyphs[$num % @glyphs];
        $num = int($num / @glyphs);
    } while $num;
    $res = reverse $res;
    $res;
}

sub to_base10 {
    my $num = shift;
	my %val = map { $glyphs[$_] => $_ } 0 .. $#glyphs;
	my $base = 1;
    my $res = 0;
	for my $char (reverse split //, $num) {
		$res += $val{$char} * $base;
		$base *= @glyphs;
    }
    $res;
}

if (@ARGV) {
	my $num = shift;
    say "base35($num) -> ", to_base35($num) unless $num =~ /\D/;
    say "base10($num) -> ", to_base10($num);
}
else {
    eval "use Test::More";
    is(to_base35(0),        "0");
    is(to_base35(10),       "A");
    is(to_base35(35),       "10");
    is(to_base35(1337),     "137");
    is(to_base35(20190401), "DFVXL");
    is(to_base10("0"),      "0");
    is(to_base10("A"),      "10");
    is(to_base10("10"),     "35");
    is(to_base10("137"),    "1337");
    is(to_base10("DFVXL"),  "20190401");
    done_testing();
}
