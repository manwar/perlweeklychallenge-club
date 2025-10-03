#!/usr/bin/perl
use 5.038;
use warnings;
use DateTime;
use DateTime::Format::Strptime;

my $strptime = DateTime::Format::Strptime->new(
    pattern => '%F',
    on_error => sub { die "Invalid date\n"; }
);

my $startDate = $strptime->parse_datetime(shift @ARGV);
my $offset = shift @ARGV;
my @bankHolidays = map { $strptime->parse_datetime($_) } @ARGV;
my $endDate = $startDate;

while ($offset > 0 ) {
    $endDate->add(days => 1);
    my $dow = $endDate->dow;
    if ($dow > 0 && $dow < 6 && !grep { $_ == $endDate } @bankHolidays) {
        $offset--;
    }
}

say $endDate->ymd;
