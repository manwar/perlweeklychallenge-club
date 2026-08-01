#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my ($num, $base, $verbose);
GetOptions(
    'n|num=i'  => \$num,
    'b|base=i' => \$base,
    'v|verbose' => \$verbose,
) or die "Usage: $0 -n <number> -b <base> [-v]\n";

die "Missing -n or -b\n" unless defined $num && defined $base;
die "Base must be between 1 and 64\n" unless $base >= 1 && $base <= 64;

if ($base == 1) {
    say '0' x $num;
}
else {
    my $result = '';

    while ($num) {
        my $digit = $num % $base;
        my $new   = int($num / $base);

        my $in_base;
        if ($digit < 10) {
            $in_base = $digit;
        }
        elsif ($digit <= 35) {
            $in_base = chr($digit - 10 + ord('A'));
        }
        elsif ($digit <= 61) {
            $in_base = chr($digit - 36 + ord('a'));
        }
        elsif ($digit == 62) {
            $in_base = '+';
        }
        else {
            $in_base = '/';
        }

        say ": $num / $base = $new + $digit -> $in_base" if $verbose;

        $result .= $in_base;
        $num = $new;
    }

    say scalar reverse $result;
}