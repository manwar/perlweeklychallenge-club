#!/usr/bin/perl

=head1

Week 183:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-183

Task #2: Date Difference

    You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.

    Write a script to find the difference between the given dates in
    terms on years and days only.

=cut

use v5.36;
use DateTime;
use Test2::V0;

is date_difference('2019-02-10', '2022-11-01'),
   '3 years 264 days', 'Example 1';

is date_difference('2020-09-15', '2022-03-29'),
   '1 year 195 days', 'Example 2';

is date_difference('2019-12-31', '2020-01-01'),
   '1 day', 'Example 3';

is date_difference('2019-12-01', '2019-12-31'),
   '30 days', 'Example 4';

is date_difference('2019-12-31', '2020-12-31'),
   '1 year', 'Example 5';

is date_difference('2019-12-31', '2021-12-31'),
   '2 years', 'Example 6';

is date_difference('2020-09-15', '2021-09-16'),
   '1 year 1 day', 'Example 7';

is date_difference('2019-09-15', '2021-09-16'),
   '2 years 1 day', 'Example 8';

done_testing;

#
#
# METHODS

sub date_difference($from, $to) {
    $from = _to_date($from);
    $to   = _to_date($to);

    my $years = 0;
    while ($from->year < $to->year) {
        my $_from = $from->clone;
        $_from->add(years => 1);
        last if ($_from gt $to);
        $years++;
        $from = $_from;
    }

    my $days = $from->delta_days($to)->{days};

    return _difference($years, $days);
}

sub _to_date($str) {
    my ($yyyy, $mm, $dd) = split /\-/, $str, 3;
    return DateTime->new(year => $yyyy, month => $mm, day => $dd);
}

sub _format($key, $value) {
    my $str = '';
    $str = sprintf("%d $key%s", $value, ($value > 1)?'s':'')
        if ($value > 0);
    return $str;
}

sub _difference($years, $days) {
    my @diff   = ();
    my %values = (year => $years, day => $days);
    foreach my $key (qw/year day/) {
        my $val = _format($key, $values{$key});
        push @diff, $val unless ($val eq '');
    }

    return join(" ", @diff);
}
