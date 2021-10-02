#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use DateTime::Format::Strptime;
use experimental 'signatures';

our ($examples, $today);

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-today=yyyy/mm/dd] [yyyy/mm/dd]

-examples
    run the examples from the challenge
 
-today=yyyy/mm/dd
    use given date as today

yyyy/mm/dd
    day of birth

EOS


### Input and Output

{
    local $, = ', ';
    say mirror_date(pop, $today);
}


### Implementation

# How should we calculate the age of a person and how should "mirroring"
# be performed?  A year is not a well defined time span due to leap
# days.  Neither is a month.  The best we can do is take the age as the
# number of days ignoring the time part.  Using DateTime math in the
# 'floating' time zone and based on day deltas seems to be
# (double-)safe.  At least this approach is consistent with the
# examples.  For meaningful results the day of birth must not lie ahead.
sub mirror_date ($dob, $today) {
    state $fmt = DateTime::Format::Strptime->new(
        pattern => '%Y/%m/%d', time_zone => 'floating');

    my $dob_dt = $fmt->parse_datetime($dob);
    my $today_dt = $today ? $fmt->parse_datetime($today) :
        DateTime->today(time_zone => 'floating');
    my $age = $today_dt->delta_days($dob_dt);

    ($fmt->format_datetime($dob_dt - $age),
        $fmt->format_datetime($today_dt + $age));
}


### Examples and tests

sub run_tests {
    my $today = '2021/09/22';

    is [mirror_date('2021/09/18', $today)],
        [qw(2021/09/14 2021/09/26)], 'example 1';
    is [mirror_date('1975/10/10', $today)],
        [qw(1929/10/27 2067/09/05)], 'example 2';
    is [mirror_date('1967/02/14', $today)],
        [qw(1912/07/08 2076/04/30)], 'example 3';

    done_testing;
    exit;
}
