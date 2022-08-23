#!/usr/bin/perl
use 5.030;
use warnings;
use DateTime;
use English;

sub nextBusinessDay {
    my ($dt) = @_; 
    my $next = $dt->clone;
    if ($dt->day_of_week == 5) {
        $next->add(days => 3);
    } elsif ($dt->day_of_week == 6) {
        $next->add(days => 2);
    } else {
        $next->add(days => 1);
    }

    return $next->set(hour => 9, minute => 0)
}

sub usage() {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <timestamp> <duration>

    <timestamp>    a datetime string in the format YYYY-MM-DD HH:MM
    <duration>     a duration as a decimal number of hours
-USAGE-
    exit 0;
}

if (scalar @ARGV != 2) {
    usage;
}

my ($timestamp, $duration) = @ARGV;

my ($year, $month, $day, $hour, $minute);
if ($timestamp =~ / ^ (\d{4}) [-] (\d{2}) \- (\d{2}) [ ] (\d{2}) [:] (\d{2}) $/msx) {
    ($year, $month, $day, $hour, $minute) = @{^CAPTURE};
} else {
    die "Bad timestamp format\n";
}

my $start = DateTime->new(
    year   => $year,
    month  => $month,
    day    => $day,
    hour   => $hour,
    minute => $minute
);

my $endOfDay = $start->clone->set(hour => 18, minute => 0);
my $endOfDuration = $start->clone->add(hours => $duration);
if ($endOfDuration <= $endOfDay) {
    say $endOfDuration->strftime('%F %H:%M');
} else {
    my $difference = $endOfDuration - $endOfDay;
    say nextBusinessDay($start)->add($difference)->strftime('%F %H:%M');
}
