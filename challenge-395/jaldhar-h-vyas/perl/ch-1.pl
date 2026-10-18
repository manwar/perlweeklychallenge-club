#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($num1, $num2) = @ARGV;

my $complex = qr/
        (?<real> \-? \d+)
        \+
        \(? (?<imaginary> \-? \d+) \)?
        i
    /msx;

$num1 =~ $complex;
my $a = $+{real};
my $b = $+{imaginary};

$num2 =~ $complex;
my $c = $+{real};
my $d = $+{imaginary};

my $real = ($a * $c - $b * $d);
my $imaginary = ($a * $d + $b * $c);

if ($imaginary < 0) {
    $imaginary = "($imaginary)";
}

say join q{}, ($real, '+', $imaginary, 'i');
