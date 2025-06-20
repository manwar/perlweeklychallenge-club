Solutions by Walt Mankowski.

# Perl Weekly Challenge #326: Day of the Year and Decompressed List

I did this week's challenges in Perl and Python. A combination of
language features and modules allowed me to solve them in just a few
lines of code.

Just a note that for each problem, I read the input via command line
arguments, and I don't do any error checking. Of course I wouldn't do
that in the real world, but here I just wanted to focus on the
algorithms and language features.

## Task #1: Day of the Year

For this task we're given a date in YYYY-MM-DD format and we're asked
to output the day of the year that date represents.

The standard way of solving this problem is the make an array with the
number of days in each month, then just add them up. The only tricky
thing is that you've got to account for leap years.

Perl and Python each have standard date/time modules that include this
logic, so rather than reinvent the wheel I just used those instead.

The Perl code is quite straightforward:

```perl
use v5.40;
use DateTime;

my ($year, $month, $day) = split '-', shift @ARGV;

my $dt = DateTime->new(
                       year  => $year,
                       month => $month,
                       day   => $day,
                      );

say $dt->day_of_year;
```

My Python code is shorter but more cryptic. This is because Python is
more of a stickler for types than Perl is. First I need to explicitly
convert the numeric strings into integers, then split the `map`
iterator into three separate values to pass into the `date`
constructor using the `*` operator.

```python
from sys import argv
from datetime import date

dt = date(*map(int, argv[1].split('-')))
print(dt.timetuple().tm_yday)
```

## Task #2 Decompressed List

For this task we're given a list of positive integers having an even
number of elements. We're to construct a new list by looking at the
original list as pairs: The first number is a count and the second is
a value. For example, if the pair is (2,3), then we repeat the number
3 two times.

My code is basically the same in both languages. The only difference
is the operator each language uses to repeat values, and how we append
those values to a list. Perl uses the `x` operator and `push`

```perl
    push @output, ($val) x $cnt;
```

while Python uses the `*` operator and `+=`:

```python
    output += [val] * cnt
```

