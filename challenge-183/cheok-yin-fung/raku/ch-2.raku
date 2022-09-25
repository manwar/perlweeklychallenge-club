# The Weekly Challenge 183
# Task 2 Date Difference
# Comment: I haven't written and checked 
#          the correctness of this script systematically.
use v6;

multi sub MAIN () {
    return;
}

multi sub MAIN (Str $datestamp1, Str $datestamp2) {
    say date-diff(Date.new($datestamp1), Date.new($datestamp2));
}

sub date-diff (Date $d1, Date $d2) {
    return speak-result(diff($d1, $d2));
}

sub diff (Date $_d1, Date $_d2) {
    my ($d1, $d2);
    if ($_d1 < $_d2) {
        ($d1, $d2) = ($_d2, $_d1);
    }
    else {
        ($d1, $d2) = ($_d1, $_d2);
    }
    my %h;
    %h{'years'} = $d1.year - $d2.year;
    if ($d1.month==$d2.month && $d1.day-of-month==$d2.day-of-month) {
        %h{'days'} = 0;
    } 
    else { 
        %h{'days'} = $d1.day-of-year - $d2.day-of-year;
        %h{'days'} += 1 if    $d2.is-leap-year 
                           && $d1.day-of-year > 60 
                           && $d2.day-of-year > 60;
    }
    if (%h{'days'} < 0) {
        %h{'years'}--;
        %h{'days'} += 365;
        %h{'days'} += 1 if    $d2.is-leap-year 
                           && $d1.day-of-year < 60 
                           && $d2.day-of-year >= 60 ;
    }
    return %h;
}



sub speak-result (%h) {
    return %h{'years'}~" years "~ %h{'days'} ~" days"
        if %h{'years'} > 1 && %h{'days'} > 1 ;
    return "1 year "~ %h{'days'} ~" days"
        if %h{'years'} == 1 && %h{'days'} > 1;
    return %h{'years'}~" years 1 day"
        if %h{'years'} > 1 && %h{'days'} == 1;
    return "1 year 1 day"
        if %h{'years'} == 1 && %h{'days'} == 1;
    return %h{'years'}~" years"
        if %h{'years'} > 1 && %h{'days'} == 0;
    return "1 year"
        if %h{'years'} == 1 && %h{'days'} == 0;
    return %h{'days'} ~" days"
        if %h{'years'} == 0 && %h{'days'} != 1 ;
    return "1 day"
        if %h{'years'} == 0 && %h{'days'} == 1;
}

use Test;
is( date-diff(Date.new('2019-02-10'), Date.new('2022-11-01')),
    "3 years 264 days");
is( date-diff(Date.new('2020-09-15'), Date.new('2022-03-29')),
    "1 year 195 days");
is( date-diff(Date.new('2019-12-31'), Date.new('2020-01-01')),
    "1 day");
is( date-diff(Date.new('2019-12-01'), Date.new('2019-12-31')),
    "30 days");
is( date-diff(Date.new('2019-12-31'), Date.new('2020-12-31')),
    "1 year");
is( date-diff(Date.new('2019-12-31'), Date.new('2021-12-31')),
    "2 years");
is( date-diff(Date.new('2020-09-15'), Date.new('2021-09-16')),
    "1 year 1 day");
is( date-diff(Date.new('2019-09-15'), Date.new('2021-09-16')),
    "2 years 1 day");

is( date-diff(Date.new('2020-02-29'), Date.new('2019-03-01')),
    "1 year",
    "weirdo non-leap year Mar 01 to leap year Feb 29"
);

is( date-diff(Date.new('2020-03-01'), Date.new('2019-03-01')),
    "1 year",
    "non-leap year Mar 01 to leap year Mar 01"
);

plan 10;

# 2020-02-29 , 2021-02-28 -> 365 days
