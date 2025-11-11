use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my @DAYS = (
    "1st",  "2nd",  "3rd",  "4th",  "5th",  "6th",  "7th",  "8th",  "9th",  "10th",
    "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
    "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th",
    "31st"
);

my @MONTHS = (
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
);

my @YEARS  = (1900..2100);

sub get_array_index_of_elem($value, @array) {
    for (my $i = 0; $i < scalar(@array); $i++) {
        return $i if ($array[$i] eq $value);
    }
    return undef;
}

sub run($str) {
    my ($day, $month, $year) = split / /, $str;
    my $res_year = get_array_index_of_elem($year, @YEARS);
    my $res_month = get_array_index_of_elem($month, @MONTHS);
    my $res_day = get_array_index_of_elem($day, @DAYS);

    return undef if (! defined $res_year || ! defined $res_month || ! defined $res_day);
    return sprintf("%s-%02d-%02d", $year, $res_month+1, $res_day+1);
}

is(run("1st Jan 2025"), "2025-01-01", "Example 1");
is(run("22nd Feb 2025"), "2025-02-22", "Example 2");
is(run("15th Apr 2025"), "2025-04-15", "Example 3");
is(run("23rd Oct 2025"), "2025-10-23", "Example 4");
is(run("31st Dec 2025"), "2025-12-31", "Example 5");
