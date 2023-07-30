#!/usr/bin/perl
use 5.030;
use warnings;
use DateTime;
use English;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <year>
  
    <year>    year between 1753 to 9999
-USAGE-
    exit(0);
}

my $year = shift // usage;
unless ($year >= 1753 && $year <= 9999) {
    usage;
}

my $count = 0;

for my $month (1 .. 12) {
    my $date = DateTime->new(year => $year, month => $month,  day => 13);
    if ($date->day_of_week == 5) {
        $count++;
    }
}

say $count;
