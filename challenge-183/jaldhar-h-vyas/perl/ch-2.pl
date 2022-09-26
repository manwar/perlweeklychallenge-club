#!/usr/bin/perl
use 5.030;
use warnings;
use DateTime;

sub parseDate {
    my ($date) = @_;
    my ($year, $month, $day) = split /-/, $date;

    return DateTime->new(
        year  => $year,
        month => $month,
        day   => $day
    );
}

if (scalar @ARGV != 2) {
    die "need two dates in the form YYYY-MM-DD\n";
}

my ($date1, $date2) = @ARGV;
my $dt1 = parseDate($date1);
my $dt2 = parseDate($date2);
my $years = ($dt1 - $dt2)->years;
my $days;

if ($dt1->year > $dt2->year) {
    $dt1 = $dt1->subtract(years => $years);
} else {
    $dt2 = $dt2->subtract(years => $years);
}

$days = $dt2->delta_days($dt1)->in_units('days');

my @output;
if ($years) {
    push @output, ( $years,  'year' . ($years == 1 ? q{} : 's') );
}
if ($days) {
    push @output, ( $days,  'day' . ($days == 1 ? q{} : 's') );
}

say join q{ }, @output;