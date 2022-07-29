Solutions by Walt Mankowski.

# Perl Weekly Challenge #175: Last Sunday and Perfect Totient Numbers

I did this week's challenge in Perl and C.

## Task #1: Last Sunday

For this task we're given a year and need to list the last Sunday of each month in that year.

My approach here was to find the day of the week for the final day of each month, then use that to determine the final Sunday. That's easy in Perl, since `DateTime.pm` has a `last_day_of_month` method. We can call the `day_of_week` method on the object it returns, which encodes Monday through Sunday as integers 1 through 7. If we take that value modulus 7 then we know how many days to subtract to get the final Sunday. Here's my full program:

```perl
use v5.36;
use DateTime;

my $year = $ARGV[0];
for my $month (1..12) {
    my $dt = DateTime->last_day_of_month(year => $year, month => $month);
    my $days_to_sunday = $dt->day_of_week % 7;
    my $final_sunday = $dt->day - $days_to_sunday;
    printf "%d-%02d-%02d\n", $year, $month, $final_sunday;
}
```

It's a bit more work in C. First we need a function to determine if `year` is a leap year:
```c
const bool is_leap_year(const int year) {
    if (year % 4)
        return false;
    else if (year % 100)
        return true;
    else if (year % 400)
        return false;
    else
        return true;
}
```

We also need encode how many days are in each month, for both non-leap and leap years:
```c
const int days_in_month[2][12] = {
    { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
    { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
};
```
I used `mktime(3)` to find the day of week of the last day of the month. It's got a few differences from `DateTime.pm`, namely:

* The months run from 0 to 11 instead of 1 to 12.
* Years start at 1900 instead of 0, so we need to subtract 1900 from the year.
* Sunday is day 0 instead of day 7.

Here's my main loop:
```c
const int year = atoi(argv[1]);
const int leap = is_leap_year(year);
for (int month = 0; month < 12; month++) {
    struct tm ts;
    memset(&ts, 0, sizeof(ts));
    ts.tm_mon = month;
    ts.tm_year = year - 1900;
    ts.tm_mday = days_in_month[leap][month];
    ts.tm_isdst = -1;
    mktime(&ts);
    printf("%d-%02d-%2d\n", ts.tm_year + 1900, month+1, ts.tm_mday - ts.tm_wday);
}
```

## Task 2: Perfect Totient Numbers

For this task we need to generate the first 20 [Perfect Totient Numbers](https://en.wikipedia.org/wiki/Perfect_totient_number). A perfect totient number is an integer that's equal to the sum of its iterated totients. The **totient** of an integer _n_ is the number of positive integers less than _n_ which are relatively prime to _n_. 

Two integers are relatively prime if their greatest common divisor (GCD) is 1. I used the elegant [Euclidian Algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm) to compute the GCD:
```perl
sub gcd($a, $b) {
    return $b ? gcd($b, $a % $b) : $a;
}
```

To solve the problem I first computed the totient for every number up to 6000. Why 6000? Well, we know from the problem definition that the 20th perfect totient number is 5571, so I figured I'd go a little higher.
```perl
my @totient = (0,0);
my $MAX = 6000;
for my $n (2..$MAX) {
    for my $i (1..$n-1) {
        $totient[$n]++ if gcd($n, $i) == 1;
    }
}
```

Then it's easy to loop over `@totient` and find all the perfect values:
```perl
my @perfect;
my $i = 2;
while (@perfect < 20) {
    my $tot = $totient[$i];
    my $sum = $tot;
    while ($tot != 1) {
        last if $sum > $i;
        $tot = $totient[$tot];
        $sum += $tot;
    }
    push @perfect, $i if $sum == $i;
    $i++;
}

say "@perfect";
```

This runs in a little over 40 seconds on my home Linux box using perl 5.36.0. My C solution, which uses exactly the same algorithm, runs in about 0.7 seconds.