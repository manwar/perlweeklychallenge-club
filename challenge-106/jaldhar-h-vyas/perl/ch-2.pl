#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ _no-match-vars /;
use integer;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N> <D>

    <N>    numerator
    <D>    denominator (not 0)
-USAGE-
    exit 0;
}

if (scalar @ARGV != 2) {
    usage();
}

my ($N, $D) = @ARGV;

if ($D == 0) {
    usage();
}

my $output = '';
if ($N == 0) {
    $output = '0';
} else {
    $output .= (($N < 0) ^ ($D < 0)) ? q{-} : q{};

    my $numerator = abs($N);
    my $denominator = abs($D);

    $output .= ($numerator / $denominator);

    if ($numerator % $denominator != 0) {

        $output .= '.';

        my $remainder = $numerator % $denominator;
        my %remainderMap;

        my $index = 0;
        my $repeating = undef;

        while ($remainder > 0 && !$repeating) {
            if (exists $remainderMap{$remainder}) {

                $index = $remainderMap{$remainder};
                $repeating = 1;
                last;

            } else {
                $remainderMap{$remainder} = (length $output) - 1;
            }

            $remainder *= 10;

            my $temp = $remainder / $denominator;
            $output .= $temp;
            $remainder = $remainder % $denominator;

        }

        if ($repeating) {
            $output .= ')';
            my $x = substr($output, $index, 1);
            substr($output, $index, 1) = "$x(";
        }
    }
}

say $output;
