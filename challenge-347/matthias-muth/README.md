# Leave a Date and a Number, and I'll Get Back to You

**Challenge 347 solutions in Perl by Matthias Muth**

## Task 1: Format Date

> You are given a date in the form: 10th Nov 2025.<br/>
> Write a script to format the given date in the form: 2025-11-10 using the set below.<br/>
> @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")<br/>
> @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")<br/>
> @YEARS  = (1900..2100)
>
> **Example 1**
>
> ```text
> Input: $str = "1st Jan 2025"
> Output: "2025-01-01"
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "22nd Feb 2025"
> Output: "2025-02-22"
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "15th Apr 2025"
> Output: "2025-04-15"
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "23rd Oct 2025"
> Output: "2025-10-23"
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "31st Dec 2025"
> Output: "2025-12-31"
> ```

I have three versions:

#### The Quick-and-Dirty Fair-Weather Version

If I am sure that all the dates that will ever be passed in are correctly formatted, this is my short solution:

```perl
use v5.36;
use Time::Piece;

sub format_date_q_a_d( $str ) {
    $str =~ s/st|nd|rd|th//;
    my $t = Time::Piece->strptime( $str, "%d %b %Y" );
    return $t->strftime( "%Y-%m-%d" );
}
```

Assuming that nothing can go wrong (but we know it will!), this is what it does:

* Remove any known suffixes from the day numbers.
* Let `strptime` from `Time::Piece` do the work of translating the date from text into a date-and-time object.
* Then do the inverse, and format the date as we need it, using the object's `strftime` method.

Very easy, very short, very readable.

But what happens when the date is not recognized by `strptime`?<br/>It's really bad, but `strptime` will make our program abort!

#### The 'Strict' and Safe Version

Letting the program abort when there is an unrecognizable date is not acceptable.
There need to be some checks to avoid it.

Let's be really strict and accept only correctly formatted dates. These are the checks:

1. The ordinal suffixes have to match the numbers, like `1st`, `2nd`, `3rd` or `4th`.<br/>
   A date like `5st Nov 2025` is invalid.<br/>
   The way to do that is to remove only suffixes that are preceded by the matching digit:

   ```perl
       $str =~ s/ (?<=1)st | (?<=2)nd | (?<=3)rd | (?<=\d)th //x;
   ```

2. `strptime` will abort even for correctly formatted dates in some cases, such as '31st Dec 1899'.<br/>To catch these exceptions, I use the `try`/`catch` syntax, enabled with  `use feature 'try'`:

   ```perl
       my $t = do {
           try { Time::Piece->strptime( $str, "%d %b %Y" ) }
           catch( $e ) { undef }
       };
   ```

   This results in `$t` being undefined if `strptime` had any problems. Anything not properly recognized by `strptime` will be marked as an invalid date.

3. `strptime` refuses dates prior to the year 1900, but accepts dates beyond the year 2100.<br/>
   We have to check and refuse those explicitly.

4. For a date of `29th Feb` in a leap year, `strptime` returns an object with the correct date.<br/>For `29th Feb` in non-leap years, however, it returns an object containing the 1st of March. Seems the checks for day numbers are not strict enough in `strptime` (a date of `30th Feb` will be refused!).<br/>So we have to check and refuse `29th Feb` in non-leap years explicitly as well.<br/>But instead of implementing a complete leap year calculation here, I take a shortcut:<br/>I reformat the object as a date string in the same format as the original string. Then I compare the two (with the ordinal suffix in the original string removed, but a `0` prepended if the day number is only one digit).
   If they are not the same, `strptime` must have worked outside of the specification, and the date will be refused as invalid.

```perl
sub format_date_strict( $str ) {
    $str =~ s/ (?<=1)st | (?<=2)nd | (?<=3)rd | (?<=\d)th //x;
    my $t = do {
        try { Time::Piece->strptime( $str, "%d %b %Y" ) }
        catch( $e ) { undef }
    };
    return
        $t && ( 1900 <= $t->year <= 2100 )
            && $t->strftime( "%d %b %Y" ) eq $str =~ s/^\d\s/0$&/r
        ? $t->strftime( "%Y-%m-%d" )
        : "<invalid date>";
}
```

Much better.

But now I was wondering whether it would be too complicated to build the while solution myself...

#### The Home-Brewed Solution

For building all the translations and boundary checks ourselves, we need some lists and lookup tables.<br/>
We will need to look up the month number for the month's short name. Of course, using a hash is the proven solution for this. Instead of writing out all the indexes (month numbers), I let the program do that work and start with a list of month short names:

```perl
    my @month_names = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
```

The lookup hash can then be generated, having in mind that an array start with index 0, but the first month has month number 1:

```perl 
    my %months = map { ( $month_names[$_] => $_ + 1 ) } keys @month_names;
```

We also need the list of days per month (the entry at index 0 has to be there, but can be ignored.<br/>The exceptions for leap days in February will be dealt with later:

```perl
    my @days_per_month = qw( 0 31 29 31 30 31 30 31 31 30 31 30 31 );
```

The rest of the task is very similar to the previous solution, only the call to `strptime` is replaced by a regular expression for extracting day, month short name and year, followed by a lookup of the month number.

Two additional checks are brought into place:

* checking the day number against the number of days in the given month,
* and checking that we are not on `29th Feb`, or if we are, it is a valid leap year.

Concluding the home-brewed solution:

```perl  
sub format_date_own( $str ) {
    my @month_names = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my %months = map { ( $month_names[$_] => $_ + 1 ) } keys @month_names;
    my @days_per_month = qw( 0 31 29 31 30 31 30 31 31 30 31 30 31 );

    $str =~ s/ (?<=1)st | (?<=2)nd | (?<=3)rd | (?<=\d)th //x;
    my ( $day, $month_name, $year ) = $str =~ /^(\d{1,2}) (...) (\d{4})$/;
    my $month = $month_name && $months{$month_name};
    return
        $year && ( 1900 <= $year <= 2100 )
            && $month && $day <= $days_per_month[$month]
            && ( $month != 2 || $day != 29
                || ( $year % 4 == 0 && $year % 100 != 0 || $year % 1000 == 0 ) )
        ? sprintf( "%d-%02d-%02d", $year, $month, $day )
        : "<invalid date>";
}
```

#### Testing Them All

I have added quite a few additional test cases to the examples from the task description.

For the Fair-Weather solution, all tests that have 'strict' in their name are run, but marked as 'To Do', to not count them as failures when they actually fail.

These are all the tests. The implementation for running them (with `Test2::V0`) can be seen in the code.

```perl
my @tests = (
    [ 'Example 1', '1st Jan 2025', '2025-01-01' ],
    [ 'Example 2', '22nd Feb 2025', '2025-02-22' ],
    [ 'Example 3', '15th Apr 2025', '2025-04-15' ],
    [ 'Example 4', '23rd Oct 2025', '2025-10-23' ],
    [ 'Example 5', '31st Dec 2025', '2025-12-31' ],
    [ 'Strict Test 1 (boundaries)', '1st Jan 1900', '1900-01-01' ],
    [ 'Strict Test 2 (boundaries)', '31st Dec 2100', '2100-12-31' ],
    [ 'Strict test 3 (out of range)', '31st Dec 1899', '<invalid date>' ],
    [ 'Strict test 4 (out of range)', '1st Jan 2101', '<invalid date>' ],
    [ 'Strict test 5 (leap day)', '29th Feb 2000', '2000-02-29' ],
    [ 'Strict test 6 (leap day)', '29th Feb 2004', '2004-02-29' ],
    [ 'Strict test 7 (non-existing leap day)', '29th Feb 1900', '<invalid date>' ],
    [ 'Strict test 8 (non-existing leap day)', '29th Feb 2001', '<invalid date>' ],
    [ 'Strict test 9 (non-existing leap day)', '29th Feb 2100', '<invalid date>' ],
    [ 'Strict test 10 (empty string)', '', '<invalid date>' ],
    [ 'Strict test 11 (random non-date string', 'xxx', '<invalid date>' ],
    [ 'Strict test 12 (invalid suffix)', '5st Dec 2025', '<invalid date>' ],
    [ 'Strict test 13 (invalid lower case)', '1st jan 1970', '<invalid date>' ],
    [ 'Strict test 14 (non-existing)', '35th Dec 2025', '<invalid date>' ],
    [ 'Strict test 15 (non-existing)', '29th Feb 1900', '<invalid date>' ],
    [ 'Strict test 16 (non-existing)', '29th Feb 2001', '<invalid date>' ],
    [ 'Strict test 17 (non-existing)', '29th Feb 2100', '<invalid date>' ],
);
```



## Task 2: Format Phone Number

> You are given a phone number as a string containing digits, space and dash only.<br/>
> Write a script to format the given phone number using the below rules:<br/>
> 1. Removing all spaces and dashes<br/>
> 2. Grouping digits into blocks of length 3 from left to right<br/>
> 3. Handling the final digits (4 or fewer) specially:<br/>
>    - 2 digits: one block of length 2<br/>
>    - 3 digits: one block of length 3<br/>
>    - 4 digits: two blocks of length 2<br/>
> 4. Joining all blocks with dashes
>
> **Example 1**
>
> ```text
> Input: $phone = "1-23-45-6"
> Output: "123-456"
> ```
>
> **Example 2**
>
> ```text
> Input: $phone = "1234"
> Output: "12-34"
> ```
>
> **Example 3**
>
> ```text
> Input: $phone = "12 345-6789"
> Output: "123-456-789"
> ```
>
> **Example 4**
>
> ```text
> Input: $phone = "123 4567"
> Output: "123-45-67"
> ```
>
> **Example 5**
>
> ```text
> Input: $phone = "123 456-78"
> Output: "123-456-78"
> ```

I start with removing all non-digit characters from the string, and then I collect groups of 3 digits, but also allowing for only 2 or 1 digit when we reach the end.

If the last group has 3 or 2 digits, we can leave the groups as they are. Only if the last group has only one digit we need to 'borrow' the last digit from the previous group and prepend it to the one in the last group, so that we end up with two groups of 2 digits each.

It's nice that we can easily access the last group with `$groups[-1]` and the second but last with `$groups[-2]`. And it also is nice and easy that we can remove the last character of the last group with<br/>
`substr( $groups[-1], -1, 1, "" )`<br/>
and directly put it in front of the second but last group with<br/>`substr( $groups[-2], 0, 0, ... )`.

So here we go:

```perl
use v5.36;

sub format_phone_number( $phone ) {
    for ( $phone ) {
        s/\D//g;
        my @groups = /(..?.?)/g;
        substr( $groups[-1], 0, 0, substr( $groups[-2], -1, 1, "" ) )
            if length( $groups[-1] ) == 1;
        return join "-", @groups;
    }
}
```

#### **Thank you for the challenge!**
