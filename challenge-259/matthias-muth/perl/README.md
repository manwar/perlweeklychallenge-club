# I Have a Date With a Parser

**Challenge 259 solutions in Perl by Matthias Muth**

Aha!<br/>This week's challenges are quite a bit more 'challenging' than many other recent ones!<br/>
Very nice!

Let's see!

## Task 1: Banking Day Offset

> You are given a start date and offset counter. Optionally you also get bank holiday date list.<br/>
> Given a number (of days) and a start date, return the number (of days) adjusted to take into account non-banking days. In other words: convert a banking day offset to a calendar day offset.<br/>
> Non-banking days are:<br/>
> a) Weekends<br/>
> b) Bank holidays<br/>
> <br/>
> Example 1<br/>
> Input: \$start_date = '2018-06-28', \$offset = 3, \$bank_holidays = ['2018-07-03']<br/>
> Output: '2018-07-04'<br/>
> Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)<br/>
><br/>
> Example 2<br/>
> Input: \$start_date = '2018-06-28', \$offset = 3<br/>
> Output: '2018-07-03'<br/>

I am going to use the `Time::Piece` module here, which is a core module,
and which gives me easy access to weekday information for the dates we will be working with.
I will also use `Time::Seconds`,
for using constants like `ONE_DAY` (actually only for that one).

So we start like this: 

```perl
#!/usr/bin/env perl
use v5.36;
use Time::Piece;
use Time::Seconds;
```
The reason I use Perl 5.36 explicitly is to have all the nice things like
`strict`, `warnings`, and `feature signatures`
without needing to list all of them. In this challenge, I also find good use of 'chained comparisons', which have been available since Perl 5.32.

I declare some own constants, so that I can refer to some selected `Time::Piece::wday` weekday numbers symbolically:

```perl
# Time::Piece::wday starts with 1 == Sunday.
use constant { WDAY_SUNDAY => 1, WDAY_MONDAY => 2, WDAY_FRIDAY => 6,
               WDAY_SATURDAY => 7 };
```

Now let's go pushing dates around.<br/>
If the original starting date is on a Saturday or Sunday, we move it back to
Friday. This avoids jumping too far when we skip over Saturdays and
Sundays later.
We don't need to adjust `$offset` when we do that, because for any of Friday,
Saturday and Sunday, an offset of 1 (for example) will result in the same following Monday.

```perl
    $start_date -=
        $start_date->wday == WDAY_SATURDAY ? 1 * ONE_DAY :
        $start_date->wday == WDAY_SUNDAY   ? 2 * ONE_DAY : 0;
```

Now we calculate the Monday of the working week that our starting date is in.
Doing this so that later,
we can increment week-wise by seven calendar days
for every five banking days in `$offset`
to skip over weekends.<br/>
To compensate for this shift backwards,
here we do need to increase the 'offset' by the number of days we shifted.

```perl
    my $days_from_monday = $start_date->wday - WDAY_MONDAY;
    my $start_monday = $start_date - $days_from_monday * ONE_DAY;
    $offset += $days_from_monday;
```
Now we can do the end date calculation.<br/>
We don't loop over each single day, but we skip over `$offset` days in one go,
plus two weekend days for every full five banking days:

```perl
    my $end_date = $start_monday
        + $offset * ONE_DAY
        + int( $offset / 5 ) * 2 * ONE_DAY;
```

We still need to shift by one day for each banking holiday between the starting and ending date.

We can ignore banking holidays that are on weekends, because we have skipped over the weekends already.
So we only consider banking holidays that are on Monday to Friday.

We need to be careful not to end on the weekend when we move the ending date forward.
We therefore add three days instead of one when the current ending date is on a Friday, to end up on the following Monday.

We go through the bank holidays one by one.
Assuming that they are ordered, we are safe even when
there are several of them in a row at the end of our time period,
because we push the end date forward *before* considering the next bank holiday to be within our time span.

```perl
    for ( $bank_holidays->@* ) {
        my $bank_holiday = Time::Piece->strptime( $_, "%Y-%m-%d" );
        if ( $start_date <= $bank_holiday <= $end_date
            && WDAY_MONDAY <= $bank_holiday->wday <= WDAY_FRIDAY )
        {
            $end_date += ( $end_date->wday == WDAY_FRIDAY ? 3 : 1 ) * ONE_DAY;
        }
    }
```
Now that this is done we are good to return the computed end date, in ISO (YYYY-MM-DD) text form.
```perl
    return $end_date->ymd;
}
```

Nice challenge!

## Task 2: Line Parser

> You are given a line like below:
>
> ```
> {%  id   field1="value1"    field2="value2"  field3=42 %}
> ```
>
> Where
>
> ```
> a) "id" can be \w+.
> b) There can be 0  or more field-value pairs.
> c) The name of the fields are \w+.
> b) The values are either number in which case we don't need double quotes or string in
>    which case we need double quotes around them.
> ```
>
> The line parser should return structure like below:
>
> ```
> {
>        name => id,
>        fields => {
>            field1 => value1,
>            field2 => value2,
>            field3 => value3,
>        }
> }
> ```
>
> It should be able to parse the following edge cases too:
>
> ```
> {%  youtube title="Title \"quoted\" done" %}
> ```
>
> **and**
>
> ```
> {%  youtube title="Title with escaped backslash \\" %}
> ```
>
> **BONUS**: Extend it to be able to handle multiline tags:
>
> ```
> {% id  filed1="value1" ... %}
> LINES
> {% endid %}
> ```
>
> You should expect the following structure from your line parser:
>
> ```
> {
>        name => id,
>        fields => {
>            field1 => value1,
>            field2 => value2,
>            field3 => value3,
>        }
>        text => LINES
> }
> ```

Now this is a good challenge, too!

One reason why I love Perl is that regular expressions are an integral part of the language. Happy to use regular expressions here!

Let's start by defining some regexes for the input tokens that we will encounter.<br/>I will make use of 'named captures' to refer to recognized parts of the input by name, not just by the capture group numbers.
Hoping that this helps to make the code less cryptic.

I built the captures right into the token regexes, mainly because when we read 'quoted text', we only want the contents of the quoted strings, without the quotes. So the capturing parentheses have to be somewhere *inside* the regex.

I use the same capture name `<value>` for both numbers and the text from a 'quoted text' token, because in the end, for assigning the value to the resulting structure, it doesn't matter whether it's a number or a text. (Hail Perl's dynamic typing!)

The 'quoted text' regex takes care for accepting escaped backslashes, escaped double quotes, or any other character that is not the (closing) double quote.

The regex for the whole structure captures all field assignments into one capture, which will then be split up and processed separately.<br/>It optionally accepts multi-line text and an end tag.<br/>The multi-line text uses a negative lookahead to end when the start of a tag (`{%`)  is encountered.<br/>The end tag has to contain 'end' and the same id that was used in the opening tag, using a named back-reference (`\g{name}`) .

```perlcounting the 
my $id_re          = qr/ (?<id>    \w+ ) /x;
my $number_re      = qr/ (?<value> \d+ ) /x;
my $quoted_text_re = qr/ " (?<value> (?: \\\\ | \\" | [^"] )* ) " /x;
my $value_re       = qr/ ${number_re} | ${quoted_text_re} /x;
my $structure_re   = qr/
        {% \s* (?<name> $id_re )
            (?<fields> (?: \s* $id_re = $value_re )* )
        \s* %}
        (?: \s* (?<text> (?: (?! {% ) . )*? )
            \s* {% \s* end\g{name} \s* %} )?
    /xs;

```

Having these tokens, the `line_parser`function simply can use the 'structure' regex to scan the input, and if it successfully matches, create the structure from the captured parts and return it.

Part of this is looping through the variable number of field assignments, and turning quoted backslashes and quoted double quotes in the values into their unquoted equivalents.

```perl
sub line_parser( $text ) {
    $text =~ /$structure_re/
        or return;
    my %structure = ( name => $+{name} );
    $structure{text} = $+{text}
        if defined $+{text};
    my $fields = $+{fields};
    while ( $fields =~ /$id_re=$value_re/g ) {
        my ( $id, $value ) = @+{ qw( id value ) };
        # Revert quoted backslashes or double quotes.
        $value =~ s/\\([\\"])/$1/g;
        $structure{fields}{$id} = $value;
    }
    return \%structure;
}
```

#### **Thank you for the challenge!**
