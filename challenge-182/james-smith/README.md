[< Previous 180](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-180/james-smith) |
[Next 182 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-182/james-smith)

# The Weekly Challenge 181

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-181/james-smith

# Task 1 - Sentence Order

***You are given a paragraph. Write a script to order each sentence alphanumerically and print the whole paragraph.***

## Solution

```perl
sub parse {
  ( join '. ',
    map { join ' ', sort { lc($a) cmp lc($b) || $a cmp $b } split }
    split /[.]\s*/, $_[0]
  ).'.'
}
```

Lets work backwards through the `parse` function.

  * We first chunk into sentences `split /[.]\s*/`
  * For each sentence we split into words `split` (Which is split `$_` on whitespace if no parameters passed)
    * Then we sort the words - primarily by *lexical order* - and if the word appers twice we sort in *ASCII* order
    * We join back each word into a sentence
  * We join the sentences back into the paragraph
  * Finally we add the trailing full-stop which we have removed...

# Task 2 - Hot Day

***You are given file with daily temperature record in random order. Write a script to find out days hotter than previous day.***

## Assumption

Even though data is an a random order we will assume that all dates are present between the start and end - as the problem is ill-defined otherwise. {You could compare dates and either give warnings or start new sequences.

## Solution

We will split the code in two 

 * first parses the file and stores it in date sorted order
 * second looks for the *hot days*

```perl
sub get_file {
  open my $fh, q(<), $_[0];
  map { m{(\d{4}-\d\d-\d\d),\s+(\d+)}?[$1,$2]:() } sort <$fh>
}
```

To sort the file into date order we just need to sort the lines of the file - as the "prefix" is date.  So `get_file`:

  * opens the file
  * sorts the lines - in string order
  * then parses each line into date and temperature - if the line is not in the right format we ignore the line - the callback returns `()`.

```perl
sub hot_day {
  my $day = shift;
  map { $_->[1] > $day->[1] ? $_->[0] : (), ($day=$_)x 0 } @_
}
```

`hot_day` just loops through those entries and outputs the hot days. We again use the trick of returning the empty list to turn the `map` into a `grep`. We update `$day` in loop, but this would get returned so we use the `x 0` trick to make this an empty list ( `x 0` on an array repeats in `0` times)

