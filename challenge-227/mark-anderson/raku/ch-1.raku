#!/usr/bin/env raku
use Test;

is friday-the-thirteenths(2023), 2;
is friday-the-thirteenths(1753), 2;
is friday-the-thirteenths(1761), 3;
is friday-the-thirteenths(9999), 1;

=begin com

for 1753..9999 -> $year 
{
    my $d = Date.new(:$year);
    my $dow = $d.day-of-week;
    my @d = map { $d.later(:month($_)) }, ^12;
    say .fmt("%-15s") given $dow, +$d.is-leap-year, +@d.grep(*.day-of-week == 7)
}

I used the program above (piped through sort -u) to create the chart below.

Jan 1st 
Day Of Week  Leap Year      Fri 13ths
--------------------------------------
1            0              2
1            1              2

2            0              2
2            1              1

3            0              1
3            1              2

4            0              3
4            1              2

5            0              1
5            1              1

6            0              1
6            1              1

7            0              2
7            1              3
--------------------------------------

It looks like the sequence repeats every 400 years so this
program should also work.

sub friday-the-thirteenths($year where * ~~ 1753..9999)
{
    .[$year - 1753] given
    <
        2 2 1 2 1 2 2 1 3 1 1 3 2 1 3 1 2 2 2 2
        1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3
        2 1 3 1 2 2 2 1 3 1 1 3 2 1 3 1 2 2 2 2
        1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3
        2 1 3 1 2 2 2 2 1 1 2 2 1 3 1 1 2 2 1 2
        1 2 2 1 3 1 1 3 2 1 3 1 2 2 2 2 1 1 2 2
        1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3 2 1 3 1
        2 2 2 2 1 1 2 2 2 1 3 1 2 2 2 2 1 1 2 2
        1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3 2 1 3 1
        2 2 2 2 1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1
        3 1 1 3 2 1 3 1 2 2 2 2 1 1 2 2 1 3 1 1
        2 2 1 2 1 2 2 1 3 1 1 3 2 1 3 1 2 2 2 2
        1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3
        2 1 3 1 2 2 2 2 1 1 2 2 1 3 1 1 2 2 1 2
        1 2 2 1 3 1 1 3 2 1 3 1 2 2 2 2 1 1 2 2
        1 3 1 1 2 2 1 2 1 2 2 1 3 1 1 3 2 1 3 1
        2 2 2 2 1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1
        3 1 1 3 2 1 3 1 1 2 2 1 3 1 1 3 2 1 3 1
        2 2 2 2 1 1 2 2 1 3 1 1 2 2 1 2 1 2 2 1
        3 1 1 3 2 1 3 1 2 2 2 2 1 1 2 2 1 3 1 1
    >.Slip xx *
}

=end com

sub friday-the-thirteenths($year where * ~~ 1753..9999)
{
    my $d = Date.new(:$year);
    
    given $d.day-of-week
    {
        when 1  { 2 }
        when 2  { $d.is-leap-year ?? 1 !! 2 }
        when 3  { $d.is-leap-year ?? 2 !! 1 }
        when 4  { $d.is-leap-year ?? 2 !! 3 }
        when 7  { $d.is-leap-year ?? 3 !! 2 }
        default { 1 }
    }
}
