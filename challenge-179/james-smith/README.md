[< Previous 178](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-178/james-smith) |
[Next 180 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-180/james-smith)

# The Weekly Challenge 179

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-179/james-smith

# Task 1 - Ordinal Number Spelling

***You are given a positive number, `$n`. Write a script to spell the ordinal number.***

## Solution

To support `$n` greater than 999 we have to split the number into chunks - much like the classic
`commify` function does.

We use a regex to split into 3 number chunks (but we reverse the number and resultant strings) so
the regex returns a list where the first chunk is either 1, 2 or 3 digits long and the rest are
3 digits long.

To get the ordinal of any number we look for the last chunk that is not `000`.

If this is the first one we need to start by computing the ordinal of that block. If not we
ignore it and find the natural number of the block and add thousandth, millionth etc.

For values > 999, we just stitch together the numbers for each block.

We have 6 list of number words:

 * 1-19
 * 20, 30, ..., 90
 * thousand, million, billion, ...  novemnonagintillion - powers of 1000...

and then the same as ordinals...

```perl
my @ord    = qw(x first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth thirteenth
                forteenth fifteenth sixteenth seventeenth eighteeinth nineteenth);
my @ord_10 = qw(z tenth twentieth thirtieth fortieth fiftieth sixtieth seventiet eightieth ninetieth hundredth);
my @power  = map { [$_,$_.'th'] } qw(x thousand), map { $_.'illion' } qw(m b tr quad quin sext sept oct nov),
              ( map { $a=$_, map { $_.$a } qw(un duo tre quattuor quin sex sept octo novem) }
              qw(dec vigint trigint quardagint quinquagint sexagint septuagint octagint nonagint) );
my @nat    = qw(a one two three four five six seven eight nine ten eleven twelve thirteen forteen fifteen
                sixteen seventeen eighteen nineteen);
my @nat_10 = qw(b ten twenty thirty fourty fifty sixty seventy eighty ninety);
```
with these phrases we can create all ordinals.

We have 2 support functions - `_natural` which gets the text version of a natural number between 1
and 999; and `_ordinal` which gets the text version of the an ordinal number between 1st and 999th.

```perl
sub ordinal {
  my ($ptr,$last,@parts,@result) = (0, map { scalar reverse } ((reverse pop) =~ m{(\d{1,3})}g));
  @result = _ordinal($last, !@parts ) if -$last;
  $ptr++, -$_ && (unshift @result, _natural($_).' '.$power[$ptr][ @result ? 0 : 1 ] ) for @parts;
  "@result" =~ s/\s+/ /gr
}

## Create a natural triple of 1s, 10, 100s
sub _natural {
  my $v = pop;
  join ' and ',
    ($v       > 99) ? $nat[$v/100].'-hundred' : (),                                ## Hundred part
    $v%100 ? ( $v%100 > 19 ? $nat_10[($v%100)/10].( $v%10 ? '-'.$nat[$v%10] : '' ) ## 20+ tens-units
             : $v%100 > 0  ? $nat[$v%100] : () ) : ()                              ## "units"
}

## Create an ordinal triple
sub _ordinal {
  my($v,$flag) = @_;

  join ' and ',
    (!$flag && $v < 100) ? '' : (),
    ($v       > 99) ? $nat[$v/100].($v%100?'-hundred':'-hundredth') : (),
    $v%100 ? ( $v%100 > 19 ? ( $v%10 ? $nat_10[($v%100)/10].'-'.$ord[$v%10] : $ord_10[($v%100)/10] )
             : $v%100 > 0  ? $ord[$v%100] : () ) : ()
}
```
### Output

```
1 -> first
6 -> sixth
10 -> tenth
19 -> nineteenth
21 -> twenty-first
45 -> fourty-fifth
90 -> ninetieth
100 -> one-hundredth
101 -> one-hundred and first
152 -> one-hundred and fifty-second
160 -> one-hundred and sixtieth
300 -> three-hundredth
999 -> nine-hundred and ninety-ninth
1000 -> one thousandth
1001 -> one thousand and first
1095 -> one thousand and ninety-fifth
1999 -> one thousand nine-hundred and ninety-ninth
2000 -> two thousandth
10000 -> ten thousandth
10001 -> ten thousand and first
1000000 -> one millionth
1000001 -> one million and first
1999999 -> one million nine-hundred and ninety-nine thousand nine-hundred and ninety-ninth
10000000 -> ten millionth
10000001 -> ten million and first
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 ->
  nine-hundred and ninety-nine novemnonagintillion nine-hundred and ninety-nine octononagintillion
  nine-hundred and ninety-nine septnonagintillion nine-hundred and ninety-nine sexnonagintillion
  nine-hundred and ninety-nine quinnonagintillion nine-hundred and ninety-nine quattuornonagintillion
  nine-hundred and ninety-nine trenonagintillion nine-hundred and ninety-nine duononagintillion
  nine-hundred and ninety-nine unnonagintillion nine-hundred and ninety-nine nonagintillion nine-hundred
  and ninety-nine novemoctagintillion nine-hundred and ninety-nine octooctagintillion nine-hundred and
  ninety-nine septoctagintillion nine-hundred and ninety-nine sexoctagintillion nine-hundred and
  ninety-nine quinoctagintillion nine-hundred and ninety-nine quattuoroctagintillion nine-hundred and
  ninety-nine treoctagintillion nine-hundred and ninety-nine duooctagintillion nine-hundred and
  ninety-nine unoctagintillion nine-hundred and ninety-nine octagintillion nine-hundred and ninety-nine
  novemseptuagintillion nine-hundred and ninety-nine octoseptuagintillion nine-hundred and ninety-nine
  septseptuagintillion nine-hundred and ninety-nine sexseptuagintillion nine-hundred and ninety-nine
  quinseptuagintillion nine-hundred and ninety-nine quattuorseptuagintillion nine-hundred and ninety-nine
  treseptuagintillion nine-hundred and ninety-nine duoseptuagintillion nine-hundred and ninety-nine
  unseptuagintillion nine-hundred and ninety-nine septuagintillion nine-hundred and ninety-nine
  novemsexagintillion nine-hundred and ninety-nine octosexagintillion nine-hundred and ninety-nine
  septsexagintillion nine-hundred and ninety-nine sexsexagintillion nine-hundred and ninety-nine
  quinsexagintillion nine-hundred and ninety-nine quattuorsexagintillion nine-hundred and ninety-nine
  tresexagintillion nine-hundred and ninety-nine duosexagintillion nine-hundred and ninety-nine
  unsexagintillion nine-hundred and ninety-nine sexagintillion nine-hundred and ninety-nine
  novemquinquagintillion nine-hundred and ninety-nine octoquinquagintillion nine-hundred and ninety-nine  
  septquinquagintillion nine-hundred and ninety-nine sexquinquagintillion nine-hundred and ninety-nine
  quinquinquagintillion nine-hundred and ninety-nine quattuorquinquagintillion nine-hundred and
  ninety-nine trequinquagintillion nine-hundred and ninety-nine duoquinquagintillion nine-hundred and
  ninety-nine unquinquagintillion nine-hundred and ninety-nine quinquagintillion nine-hundred and
  ninety-nine novemquardagintillion nine-hundred and ninety-nine octoquardagintillion nine-hundred and
  ninety-nine septquardagintillion nine-hundred and ninety-nine sexquardagintillion nine-hundred and
  ninety-nine quinquardagintillion nine-hundred and ninety-nine quattuorquardagintillion nine-hundred and
  ninety-nine trequardagintillion nine-hundred and ninety-nine duoquardagintillion nine-hundred and
  ninety-nine unquardagintillion nine-hundred and ninety-nine quardagintillion nine-hundred and ninety-nine
  novemtrigintillion nine-hundred and ninety-nine octotrigintillion nine-hundred and ninety-nine
  septtrigintillion nine-hundred and ninety-nine sextrigintillion nine-hundred and ninety-nine
  quintrigintillion nine-hundred and ninety-nine quattuortrigintillion nine-hundred and ninety-nine
  tretrigintillion nine-hundred and ninety-nine duotrigintillion nine-hundred and ninety-nine
  untrigintillion nine-hundred and ninety-nine trigintillion nine-hundred and ninety-nine novemvigintillion
  nine-hundred and ninety-nine octovigintillion nine-hundred and ninety-nine septvigintillion nine-hundred
  and ninety-nine sexvigintillion nine-hundred and ninety-nine quinvigintillion nine-hundred and ninety-nine
  quattuorvigintillion nine-hundred and ninety-nine trevigintillion nine-hundred and ninety-nine
  duovigintillion nine-hundred and ninety-nine unvigintillion nine-hundred and ninety-nine vigintillion
  nine-hundred and ninety-nine novemdecillion nine-hundred and ninety-nine octodecillion nine-hundred and
  ninety-nine septdecillion nine-hundred and ninety-nine sexdecillion nine-hundred and ninety-nine
  quindecillion nine-hundred and ninety-nine quattuordecillion nine-hundred and ninety-nine tredecillion
  nine-hundred and ninety-nine duodecillion nine-hundred and ninety-nine undecillion nine-hundred and
  ninety-nine decillion nine-hundred and ninety-nine novillion nine-hundred and ninety-nine octillion
  nine-hundred and ninety-nine septillion nine-hundred and ninety-nine sextillion nine-hundred and
  ninety-nine quinillion nine-hundred and ninety-nine quadillion nine-hundred and ninety-nine trillion
  nine-hundred and ninety-nine billion nine-hundred and ninety-nine million nine-hundred and ninety-nine
  thousand nine-hundred and ninety-ninth
```
# Task 2 - Unicode Sparkline

***You are given a list of positive numbers, `@n`. Write a script to print sparkline in Unicode for the given list of numbers.***

## Note

There is no "clear-unique" definition of a sparkline - it can take many forms - as we are using unicode we will stick with the vertical line design.

## Solution

For any row - it consists of a series of points and a series of gaps between them.
Between a point at position `$n` and `$m` the gap is size `$m-$n-1`. We then use
a loop over all the points to generate the line..

As we are using nested maps, we occassionally have entries (*e.g.* updating `$k` where
we need to hide the value we created - you can use the array version of multiply (`x`)
for this - by multiplying by `0`, e.g. `($k=$_)x 0`....

If we wished to limit the vertical height we could apply scaling to limit to 2 or 3 lines.

```perl

binmode STDOUT, ':utf8';              ## Set output to UTF

const my $LINE  => "\x{2500}";        ## Horizontal line
const my $START => "\x{2534}";        ## Inverted T
const my $FULL  => "\x{2577}";        ## Full-height line
const my $HALF  => "\x{2502}";        ## Half-height line

sub spark_line {
  my($mx,$k,$l,%x)=0
  $x{$_}++ for @{$_};                     ## Create an array of values with counts
  ($_>$mx) && ($mx=$_) for values %x;     ## Find max count..
                                          ## We could apply scaling here to keep sparkline 
                                          ## a max-height but results would not be as tood

                                          ## We layout the sparks over multiple lines - to
                                          ## accodomate height {see note on scaling to keep
                                          ## height to a given value}
                                          ## If mx > 1 we need to use multiple lines - foreach
                                          ## of these we either have a full height "|" or
                                          ## a half-height line "|" or nothing " "...
  map( {
    ($l,$k) = ($_<<1,-1); join '',
                          map { ' ' x ($_-$k-1).( $x{$_}<$l ? ' ' : $x{$_} == $l ? $FULL : $HALF ), ($k=$_)x 0 }
                          sort    { $a <=> $b }
                          keys    %x
    }
    reverse 1 .. $mx / 2
  ),
  ($k=-1)x 0,join( '', map { $LINE x ($_-$k-1) . $START, ($k=$_)x 0 } sort {$a<=>$b} keys %x )
}
```
### Output
```
200,199,198,3,4,4,10,8,7,199,10,24,10,7,10,11,20,25,3,3,3,3,3,3,3,3,3,3
   │
   │
   │
   │      ╷
   │╷  ╷  │                                                                                                                                                                                            ╷
───┴┴──┴┴─┴┴────────┴───┴┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┴┴┴
```
and
```
1,2,3,4,100,101,102
─┴┴┴┴───────────────────────────────────────────────────────────────────────────────────────────────┴┴┴
```
