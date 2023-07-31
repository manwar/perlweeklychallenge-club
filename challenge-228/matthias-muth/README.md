# Friday XIII
**Challenge 227 solutions in Perl by Matthias Muth**

## Task 1: Friday 13th

> You are given a year number in the range 1753 to 9999.<br/>
> Write a script to find out how many dates in the year are Friday 13th, assume that the current Gregorian calendar applies.<br/>
> <br/>
> Example<br/>
> Input: $year = 2023<br/>
> Output: 2<br/>
> Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and 13th Oct.<br/>

Looking for an easy way to get the weekday for a given date,
the `Time::Piece` core module is an obvious choice.

`Time::Piece`'s typical usage is for dealing with 'current' times,
which are returned by the `localtime` and `gmtime` subroutines when called without parameter.
If we want to supply a different date with them,
we need to compute Unix epoch time value to do so.
We will look into that later.

But there is also the `Time::Piece->strptime(STRING, FORMAT)` subroutine that works as a constructor
for `Time::Piece` objects.
We hand in a date string like `"2023-07-13"`, and a format of `'%Y-%m-%d'`,
and there we have our time object.

So everything in one statement (but not on one line, to make it more readable!):
- month numbers from 1 to 12,
- use a `grep` code block to create the `Time::Piece` objects on the fly,
and select those who return a day_of_week of 5 (Friday),
-  use `scalar` to put `grep` into a scalar context
so it returns the number of elements found instead of the list.

```perl
use v5.36;
use Time::Piece;
sub friday_13th( $year ) {
    return scalar grep {
        Time::Piece->strptime( "$year-$_-13", "%Y-%m-%d" )->day_of_week == 5
    } 1..12;
}
```

Now maybe `strptime` is not the fastest solution, 
and we could use `timegm` from `Time::Local` to create our dates
without the need of parsing a string with a format.
But using `strptime` like above looks much clearer to me than
converting month numbers from 1..12 to 0..11 and years to be offsets from 1900,
which would be necessary if we used `timegm`:
```perl
use v5.36;
use Time::Local;
use Time::Piece;
sub friday_13th( $year ) {
    return scalar grep {
        gmtime( timegm( 0, 0, 0, 13, $_ - 1, $year - 1900 ) )->day_of_week == 5
     } 1..12;
}
```
It's also that we would be jumping between domains
(`localtime`/`gmtime` needing that 6-element list, returning an epoch time value,
then we create a Time::Piece object from that),
which does not really make it obvious what is going on.<br/>
I prefer the first version! :-)

## Task 2: Roman Maths

> Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.<br/>
> <br/>
> Example<br/>
> IV + V     => IX<br/>
> M - I      => CMXCIX<br/>
> X / II     => V<br/>
> XI * VI    => LXVI<br/>
> VII ** III => CCCXLIII<br/>
> V - V      => nulla (they knew about zero but didn't have a symbol)<br/>
> V / II     => non potest (they didn't do fractions)<br/>
> MMM + M    => non potest (they only went up to 3999)<br/>
> V - X      => non potest (they didn't do negative numbers)<br/>

I'm sure it's an interesting exercise to convert Roman numerals to arabic (common) numbers
and vice versa, but here, I am not going to reinvent the wheel.<br/>
The `Roman` module from CPAN is my friend in this case.

The more interesting aspect is how to implement the arithmetic operations
in a more elegant way than a nested if-then-else statement.

I chose a hash lookup to return an anonymous subroutine that implements
the respective operation.

The rest looks quite self-explanatory to me.<br/>
Or is it only in my eyes???

```perl
use v5.36;
use Roman;

my %ops = (
    '+'  => sub { $_[0] + $_[1] },
    '-'  => sub { $_[0] - $_[1] },
    '*'  => sub { $_[0] * $_[1] },
    '/'  => sub { $_[0] / $_[1] },
    '**' => sub { $_[0] ** $_[1] },
);

sub roman_maths( @input ) {
    my $result = $ops{$input[1]}->( arabic( $input[0] ), arabic( $input[2] ) );
    return
        $result == 0
            ? "nulla (they knew about zero but didn't have a symbol)" :
        $result != int( $result )
            ? "non potest (they didn't do fractions)" :
        $result > 3999
            ? "non potest (they only went up to 3999)" :
        $result < 0
            ? "non potest (they didn't do negative numbers)" :
        Roman( $result );
}
```

#### **Thank you for the challenge!**
