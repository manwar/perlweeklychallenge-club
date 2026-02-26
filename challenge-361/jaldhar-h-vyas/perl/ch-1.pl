#!/usr/bin/perl
use 5.038;
use warnings;
use English;

sub subtract($remainder, $results, $i) {
    state @fibs = (89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1);

    if ($remainder <= 0) {
        return @{$results};
    }

    my $nexti = $i;
    while ($fibs[$nexti] > $remainder) {
        $nexti++;
    }
    push @{$results}, $fibs[$nexti];

    return subtract($remainder - $fibs[$nexti], $results, $nexti + 2);
}

my ($int) = @ARGV;

if ($int < 1 || $int > 100) {
print<<"-end-";
Usage:
  $PROGRAM_NAME <int>
  
    <int>    positive integer less than or equal to 100
-end-
}

say join q{,}, subtract($int, [], 0);
