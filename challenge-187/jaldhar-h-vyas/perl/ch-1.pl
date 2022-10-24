#!/usr/bin/perl
use 5.030;
use warnings;

sub dateToDays {
    my ($date) = @_;
    my @monthFirst = (-1, 30, 58, 89, 120, 150, 181, 212, 242, 273, 303, 333);
    my ($day, $month) = split '-', $date;

    return $monthFirst[$month - 1] + $day;
}

if (scalar @ARGV != 4) {
    die "Need 4 dates in the format DD-MM\n";
}

my ($fooStartDate, $fooEndDate, $barStartDate, $barEndDate) = @ARGV;

my ($fooStartDay, $fooEndDay, $barStartDay, $barEndDay) =
    map { dateToDays($_); }
    ($fooStartDate, $fooEndDate, $barStartDate, $barEndDate);

if ($fooEndDay < $barStartDay || $fooStartDay > $barEndDay) {
    say "0 days";
} else {
    my $commonStart = $fooStartDay < $barStartDay ? $barStartDay : $fooStartDay;
    my $commonEnd = $fooEndDay < $barEndDay ? $fooEndDay : $barEndDay;
    my $common = $commonEnd - $commonStart + 1;

    say "$common day", ($common == 1 ? q{} : 's');
}