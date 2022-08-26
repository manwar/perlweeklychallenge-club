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

