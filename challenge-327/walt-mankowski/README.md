Solutions by Walt Mankowski.

# Perl Weekly Challenge #326: Day of the Year and Decompressed List

I did this week's challenges in Perl and Python. A combination of
language features and modules allowed me to solve them in just a few
lines of code.

Just a note that for each problem, I read the input via command line
arguments, and I don't do any error checking. Of course I wouldn't do
that in the real world, but here I just wanted to focus on the
algorithms and language features.

Update: Several days later I added C versions of my solutions to the
challenges. See my notes at the bottom.

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

## Bonus C Implementations

It's Sunday morning and thunderstorming outside, so I decided to do C
versions of the challenges this week.

### Day of the Week in C

There are two steps to solving this challenge: parsing the date into
year, month, and day, and then computing the day of the year for that
date. C doesn't have a handy `split()` function, so instead I used
`strtok(3)`. `strtok()` works by modifying its input string, changing
instances of the token to NULL. We can't modify `argv` so first I make
a copy of it:

```c
    /* Make a copy of argv[1] so we can call strtok() on it */
    char *yyyymmdd = malloc(strlen(argv[1]) + 1);
    strcpy(yyyymmdd, argv[1]);
```

Then I used `strtok()` to find the tokens between instances of `'c'`
and store them in a `struct tm`. This structure requires year 0 to be
1900 and numbers the months starting at 0, so we need to account for
that.

```c
    /* parse the date and construct a struct tm with the year, month, and day */
    memset(&tm, 0, sizeof(tm));
    tm.tm_year = atoi(strtok(yyyymmdd, "-")) - 1900;
    tm.tm_mon = atoi(strtok(NULL, "-")) - 1;
    tm.tm_mday = atoi(strtok(NULL, "-"));
```

Finally we use `mktime(3)` to convert the `struct tm` to an epoch
time and use `gmtime_r(3)` to convert it back into a `struct tm`. But
that struct has all the other information about that date populated,
and so we can just print `tm.tm_yday`. Except it's not quite that
easy, since it considers January 1 to be day 0 instead of day 1. So we
need to add 1 to it when we output it.

```c
    /* get the epoch time for midnight on that date */
    time_t t = mktime(&tm);

    /* get the yday for that time */
    gmtime_r(&t, &tm);
    printf("%d\n", tm.tm_yday + 1);
```

### Decompressed List in C

C doesn't have dynamically sized arrays like Perl and Python, so the
first thing we need to do is make a pass through `argv` to compute how
big the output array will be:

```c
size_t compute_output_len(int argc, char *argv[]) {
    size_t output_len = 0;
    for (int i = 1; i < argc; i += 2)
        output_len += atoi(argv[i]);

    return output_len;
}
```

We use that to `malloc` an array of `unsigned int`s:

```c
    /* compute how big the output array should be */
    size_t output_len = compute_output_len(argc, argv);
    unsigned int *output = malloc(output_len * sizeof(unsigned int));
```

After that, building the array and printing it out are pretty much the
same as they are in the other languages, just a bit more verbose:

```c
    /* add things to the output array */
    int k = 0;
    for (int i = 1; i < argc; i += 2) {
        int cnt = atoi(argv[i]);
        int val = atoi(argv[i+1]);
        for (int j = 0; j < cnt; j++)
            output[k++] = val;
    }

    /* print out the array */
    printf("(");
    for (int i = 0; i < output_len-1; i++)
        printf("%u, ", output[i]);
    printf("%u)\n", output[output_len-1]);
```
