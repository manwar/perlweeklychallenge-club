#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>
  
    <N>    integer greater than 9
-USAGE-
    exit 0;
}

my ($N) = shift // usage;

if ($N < 10) {
    usage;
}

my $found = 1;

for my $len (1 .. (length $N) / 2) {
    $found = 1;

    my $n =  '0' x ((length $N) % $len) . $N;
    my @digits = $n =~ /.{1,$len}/g;
    for my $group (1 .. scalar @digits - 1) {
        if (substr($digits[$group], 0, 1) == '0' || $digits[$group] - $digits[$group - 1] != 1) {
            $found = undef;
            last;
        }
    }

    if ($found) {
        @digits = map { s/^0//; $_; } @digits;
        say join q{,}, @digits;
        exit;
    }
}

if (!$found) {
    say $N;
}
