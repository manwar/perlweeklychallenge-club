use Modern::Perl;
use 5.026;
use experimental qw<signatures>;
use DateTime;

sub is_working_day ($date) {
    my $day = $date->day_of_week;
    return !($day == 6 or $day == 7);
}
sub working_days_in_year ($year) {
    my $d = DateTime->new(year => $year);

    my $working_days_count = 0;
    for (1 .. $d->year_length) {
        $working_days_count++ if is_working_day($d);
        $d->add(days => 1);
    }
    return $working_days_count;
}

use Test::More;
my @tests = (
    [ 2021, 261 ],
    [ 2020, 262 ],
);
plan tests => 0+@tests;

for (@tests) {
    my ($input_year, $expected) = @{$_};
    is working_days_in_year($input_year),   $expected,
      "working_days_in_year($input_year) == $expected";
}
