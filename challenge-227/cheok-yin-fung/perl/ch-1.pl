use v5.30.0;
use warnings;
use List::Util qw/reductions/;

sub is_leap_year {
    my $year = $_[0];
    return 1 if ($year % 4 == 0 && $year % 100 != 0) || $year % 400 == 0;
    return 0;
}

my @mon = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30);
my @mon_ly = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30);

# https://en.wikipedia.org/wiki/Zeller%27s_congruence
sub zeller_cong {
    my @day_of_week = ("Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri");
    my $year = $_[0];
    my $m = $_[1];
    my $q = $_[2];
    if ($m < 3) {
        $m = 13 if $m == 1;
        $m = 14 if $m == 2;
        $year = $year - 1;
    }
    my $J = int($year/100);
    my $K = $year % 100;
    my $h = ($q + int(13*($m+1)/5) + $K + int($K/4) + int($J/4) - 2*$J) % 7;
    return ($h+6) % 7;
}

sub num_of_black_fri {
    my $year = $_[0];
    my @arr = ();
    push @arr, zeller_cong($year, 1, 13);
    if (is_leap_year($year)) {
        @arr = reductions {$a+$b} @arr, @mon_ly;
    }
    else {
        @arr = reductions {$a+$b} @arr, @mon;
    }
    @arr = map {$_ % 7} @arr;
    return grep {$_ == 5} @arr;
}

use Test::More tests=>4;
# https://robslink.com/SAS/democd42/friday13.htm
ok num_of_black_fri(2023) == 2;
ok num_of_black_fri(2024) == 2;
ok num_of_black_fri(2025) == 1;
ok num_of_black_fri(2026) == 3;
