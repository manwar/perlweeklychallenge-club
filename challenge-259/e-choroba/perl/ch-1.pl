#!/usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

use Time::Piece ();
use Time::Seconds qw( ONE_DAY );

use constant DATE_FORMAT => '%Y-%m-%d';

sub banking_day_offset($start, $offset, $holidays=[]) {
    my %H;
    @H{@$holidays} = ();
    my $tp = 'Time::Piece'->strptime($start, DATE_FORMAT);
    my $add = 0;
    # Start date is weekend, move to Monday.
    $add += $tp->wday % 5 if $tp->wday % 6 == 1;

    # How many weeks to move forward.
    $add += 7 * int($offset / 5);

    # Remaining non-week days.
    $add += $offset % 5;

    # Add a weekend if we went over it in the remaining non-week days.
    $add += 2 if 1 != $tp->wday % 6 && $tp->wday + $offset % 5 > 6;

    my $date = $tp + ONE_DAY * $add;

    # Now handle the holidays.
    for my $h (sort keys %H) {
        my $holiday = 'Time::Piece'->strptime($h, DATE_FORMAT);
        next if $holiday < $tp || $holiday->wday % 6 == 1;
        if ($holiday <= $date) {
            $date += ONE_DAY;
            $date += 2 * ONE_DAY if $date->wday == 7;
        }
    }

    # We might still land on a weekend or holiday.
    $date += ONE_DAY while $date->wday % 6 == 1
                        || exists $H{ $date->strftime(DATE_FORMAT) };

    return $date->strftime(DATE_FORMAT)
}

sub banking_day_offset_slow($start, $offset, $holidays=[]) {
    my %H;
    @H{@$holidays} = ();
    my $tp = 'Time::Piece'->strptime($start, DATE_FORMAT);
    $tp += ONE_DAY while $tp->wday % 6 == 1
                      || exists $H{ $tp->strftime(DATE_FORMAT) };
    for (1 .. $offset) {
        $tp += ONE_DAY;
        $tp += ONE_DAY while $tp->wday % 6 == 1
                          || exists $H{ $tp->strftime(DATE_FORMAT) };
    }
    return $tp->strftime(DATE_FORMAT)
}

use Test::More tests => 2 + 1;

my %DISPATCH = (slow => \&banking_day_offset_slow,
                fast => \&banking_day_offset);

for my $how (qw( slow fast )) {
    my $banking_day_offset = $DISPATCH{$how};

    subtest $how => sub {
        is $banking_day_offset->('2018-06-28', 3, ['2018-07-03']),
            '2018-07-04',
            'Example 1';

        is $banking_day_offset->('2018-06-28', 3),
            '2018-07-03',
            'Example 2';

        is $banking_day_offset->('2018-06-28', 2, ['2018-07-02', '2018-07-03']),
            '2018-07-04',
            'Land in the middle of holidays';

        is $banking_day_offset->('2018-06-28', 2, ['2018-07-01', '2018-06-30']),
            '2018-07-02',
            'Holidays on a weekend';

        is $banking_day_offset->('2024-01-01', 262),
            '2025-01-01',
            'Whole year';

        is $banking_day_offset->('2018-06-28', 101, [qw[ 2018-11-16 2018-11-19]]),
            '2018-11-20',
            'Holidays wrap a weekend';

        is $banking_day_offset->('2012-05-22', 161, ['2012-05-22']),
            '2013-01-03',
            'Start on a holiday';
    }, 2 + 5;
}

use Benchmark qw{ cmpthese };

my $start = '2003-04-20';
my $offset = 731;
my @h = qw[ 2001-10-08 2005-02-20 2000-01-07 2003-09-26 2000-08-14
            2008-09-22 2003-05-10 2004-05-12 2004-10-12 2008-06-12
            2003-06-15 2003-09-20 2006-08-01 2009-02-18 2006-07-11
            2008-04-01 2003-10-03 2008-08-07 2008-11-17 2009-02-03
            2004-08-18 2005-04-23 2003-08-15 2007-03-22 2004-11-07
            2004-08-13 2008-09-04 2003-06-27 2006-07-12 2003-11-06
            2000-01-30 2006-11-26 2004-07-05 2007-03-07 2000-12-11
            2001-01-17 2007-01-18 2002-05-01 2000-01-06 2000-03-03
            2005-09-05 2001-01-03 2005-06-02 2003-08-15 2002-09-13
            2006-07-15 2005-06-22 2001-10-27 2005-07-14 2004-09-19
            2008-02-10 2003-05-10 2007-08-11 2000-02-05 2002-01-25
            2002-03-28 2003-07-26 2007-08-13 2002-03-21 2003-03-09
            2006-03-11 2004-03-05 2004-05-08 2006-09-24 2000-10-03
            2001-12-19 2003-02-26 2005-10-06 2001-08-23 2004-09-25
            2009-12-20 2004-10-10 2005-08-15 2001-11-25 2002-03-11
            2007-10-22 2000-10-30 2009-04-14 2009-10-30 2004-09-01
            2004-04-11 2000-04-04 2003-11-14 2004-11-16 2001-06-28
            2008-11-18 2009-11-16 2006-01-27 2007-08-06 2009-09-14
            2000-10-25 2001-09-14 2000-09-17 2007-01-07 2005-02-05
            2000-09-20 2002-02-01 2003-05-08 2002-06-03 2006-12-02
            2009-08-15 2008-11-22 2002-12-23 2002-06-08 2003-09-27
            2004-10-08 2007-12-16 2005-12-19 2003-05-15 2007-10-30
            2006-11-13 2005-12-04 2006-09-06 2005-05-08 2007-10-23
            2006-05-31 2005-01-16 2009-02-15 2000-05-08 2002-04-13
            2000-07-11 2005-05-25 2004-07-03 2007-12-03 2008-07-19
            2009-08-27 2004-08-27 2002-03-14 2007-03-29 2005-02-03
            2004-10-30 2000-07-14 2004-01-27 2004-12-18 2004-12-08
            2005-11-23 2008-04-18 2000-03-06 2009-05-31 2002-08-13
            2000-12-25 2008-09-17 2004-06-10 2003-04-29 2003-04-28
            2000-04-30 2005-04-18 2003-08-01 2000-05-22 2009-03-18
            2002-08-08 2008-11-15 2006-03-17 2003-07-17 2006-10-02
            2007-01-17 2009-09-04 2000-04-22 2007-04-23 2006-01-08
            2003-08-01 2003-08-11 2003-02-10 2007-04-08 2003-02-26
            2002-05-16 2002-11-04 2004-01-07 2001-09-28 2001-11-29
            2002-03-19 2009-10-08 2002-08-25 2004-08-22 2003-06-23
            2001-05-23 2000-12-02 2000-04-26 2000-05-25 2006-05-15
            2006-08-18 2009-12-26 2008-07-31 2009-10-02 2002-07-19
            2006-08-01 2000-06-09 2006-04-10 ];

is banking_day_offset($start, $offset, [@h]),
    banking_day_offset_slow($start, $offset, [@h]),
    'long';

cmpthese(-3, {
    slow => sub { banking_day_offset_slow($start, $offset, [@h]) },
    fast => sub { banking_day_offset($start, $offset, [@h]) },
})

__END__
       Rate slow fast
slow 84.1/s   -- -80%
fast  431/s 412%   --
