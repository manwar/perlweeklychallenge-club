#!/usr/bin/perl
use 5.020;
use warnings;
use English qw / -no_match_vars /;

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <n>
  
    <n>    an integer
-USAGE-
    exit 0;
}

sub squareRoot {
    my ($n) = @_;

    my $firstTry = $n >> 1;

    if ( $firstTry ) {
        my $nextTry = ( $firstTry + $n / $firstTry) >> 1;

        while ( $nextTry < $firstTry) {
            $firstTry = $nextTry;
            $nextTry = ( $firstTry + $n / $firstTry) >> 1;
        }

		return $firstTry;
	} else {
		return $n;
	}
}


my $n = shift // usage;

say squareRoot($n);