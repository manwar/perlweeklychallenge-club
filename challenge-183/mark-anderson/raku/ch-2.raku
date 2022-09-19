#!/usr/bin/env raku
use Test;

is-deeply date-diff('2019-02-10', '2022-11-01'), (3, 264);
is-deeply date-diff('2020-09-15', '2022-03-29'), (1, 195);
is-deeply date-diff('2019-12-31', '2020-01-01'), (0, 1);
is-deeply date-diff('2019-12-01', '2019-12-31'), (0, 30);
is-deeply date-diff('2019-12-31', '2020-12-31'), (1, 0);
is-deeply date-diff('2019-12-31', '2021-12-31'), (2, 0);
is-deeply date-diff('2020-09-15', '2021-09-16'), (1, 1);
is-deeply date-diff('2019-09-15', '2021-09-16'), (2, 1);
is-deeply date-diff('2014-02-10', '2015-03-10'), (1, 28);
is-deeply date-diff('2020-03-01', '2023-03-10'), (3, 9);
is-deeply date-diff('2020-03-01', '2024-03-10'), (4, 9);
is-deeply date-diff('2020-02-27', '2021-02-28'), (1, 1);
is-deeply date-diff('2000-02-01', '2008-02-01'), (8, 0);
is-deeply date-diff('2020-02-29', '2024-02-29'), (4, 0);
is-deeply date-diff('2000-02-10', '2000-03-10'), (0, 29);
is-deeply date-diff('2020-02-29', '2021-02-27'), (0, 364);
is-deeply date-diff('2020-02-29', '2025-02-27'), (4, 364);
is-deeply date-diff('2020-02-29', '2021-02-28'), (0, 365);
is-deeply date-diff('2020-02-29', '2029-02-28'), (8, 365);
is-deeply date-diff('2020-02-29', '2029-03-01'), (9, 1);
is-deeply date-diff('2020-02-10', '2025-02-08'), (4, 363);
is-deeply date-diff('2020-02-10', '2025-02-28'), (5, 18);
is-deeply date-diff('2020-02-10', '2028-02-29'), (8, 19);

multi date-diff(Str $s1, Str $s2)
{
    date-diff(Date.new($s1), Date.new($s2));
}

multi date-diff($d1, $d2 where {$d1.month == $d2.month and $d1.day == $d2.day})
{
    ($d2.year - $d1.year, 0)
}

multi date-diff($d1, $d2 where $d2 - $d1 < 365)
{
    (0, $d2 - $d1)
}

multi date-diff($d1, $d2 is copy where {$d1.month == 2 and $d1.day == 29})
{
    my $y = $d2.year - $d1.year;
    $y-- if $d1.month == $d2.month;
    $d2 .= earlier(years => $y);
    ($y, $d2 - $d1);
}

multi date-diff($d1, $d2)
{
    my $days = $d2 - $d1;
    my $leap-years := ($d1.year..$d2.year).grep({ Date.new(year => $_).is-leap-year });
    my $leap-ds := $leap-years.map({ Date.new(year => $_, month => 2, day => 29) });    
    $days -= $leap-ds.grep({ $d1 < $_ < $d2 });
    $days.polymod(365)[1,0];
}
