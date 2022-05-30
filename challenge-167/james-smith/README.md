[< Previous 165](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-165/james-smith) |
[Next 167 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-167/james-smith)

# The Weekly Challenge 166

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-166/james-smith

# Challenge 1 - Hex words....

Now I've concentrated on challenge 2 this week but here is some of my code for Challenge 1

## Solution
Find all hex words, this generates all words, with options for adding filters - to
restrict the number of numbers - to only letters or all letters. By commenting/uncommenting
the filter lines.... I have added one more mapping that is in standard use which is
`g` -> `9` {others use `6` but it still works}

```perl
while(<>) {
  chomp;
  next unless m{^[abcdefoilstg]+$};
  my $t = $_;
  my $N = tr/oilstg/011579/;
  next if $N < length $_;
  #next if $N > 0;
  #next if $N > 15;
  warn "$N\t$t\t$_\n" if $N == length $_;
  $words->[length $_]{$N}{$t}="$_ (".hex($_).")";
}

print Dumper( $words );
```

## Some observations

### Longest words
```
 falsifiabilities  0x fa15 1f1a b111 71e5  (18,020,343,683,493,229,029)
 dissociabilities  0x d155 0c1a b111 71e5  (15,083,975,835,726,737,893)
 lactobacillaceae  0x 1ac7 0bac 111a ceae  ( 1,929,523,799,000,796,846)
```
Can add (if we include the g->9 mapping):
```
 silicoflagellate  0x 5111 c0f1 a9e1 1a7e  ( 5,841,662,335,845,997,182)
```
### Longest word with at most `n` numbers:

**0-numbers** - 8 letters
```
 fabaceae          0x 0000 0000 faba ceae  (             4,206,546,606)
```
**1-number**  - 10 lettters
```
 defaceable        0x 0000 00de face ab1e  (           957,690,587,934)
 defaecated        0x 0000 00de faec a7ed  (           957,692,553,197)
 effaceable        0x 0000 00ef face ab1e  (         1,030,705,031,966)
```
**2-numbers/3-numbers** - 12 letters
```
 fiddledeedee      0x 0000 f1dd 1ede edee  (       265,932,007,992,814)
```
**4-numbers** - 12 letters
```
 fiddledeedee      0x 0000 f1dd 1ede edee  (       265,932,007,992,814)
 acetoacetate      0x 0000 ace7 0ace 7a7e  (       190,108,318,726,782)
 cicadellidae      0x 0000 c1ca de11 1dae  (       213,077,053,218,222)
```
**5-numbers** - 13 letters
```
 blastodiaceae     0x 000b 1a57 0d1a ceae  (     3,125,185,928,154,798)
```
**6-numbers -- 9-numbers** - 16 letters
```
 lactobacillaceae  0x 1ac7 0bac 111a ceae  ( 1,929,523,799,000,796,846)
```
**10-numbers** - 16 letters
```
 lactobacillaceae  0x 1ac7 0bac 111a ceae  ( 1,929,523,799,000,796,846)
 falsifiabilities  0x fa15 1f1a b111 71e5  (18,020,343,683,493,229,029)
```
Can add (if we include the g->9 mapping {could also do g->6}):
```
 silicoflagellate  0x 5111 c0f1 a9e1 1a7e  ( 5,841,662,335,845,997,182)
```
**11+-numbers** - 16 letters
```
 lactobacillaceae  0x 1ac7 0bac 111a ceae  ( 1,929,523,799,000,796,846)
 falsifiabilities  0x fa15 1f1a b111 71e5  (18,020,343,683,493,229,029)
 dissociabilities  0x d155 0c1a b111 71e5  (15,083,975,835,726,737,893)
```
Can add (if we include the g->9 mapping {could also do g->6}):
```
 silicoflagellate  0x 5111 c0f1 a9e1 1a7e  ( 5,841,662,335,845,997,182)
```

### Longest word with all numbers:
```
 soloists          0x 0000 0000 5010 1575  (             1,343,231,349)
 titlists          0x 0000 0000 7171 1575  (             1,903,236,469)
```
If we include the g->9 mapping we can have:
```
 glossologists     0x 0000 91055 0109 1575 (     2,551,232,066,033,013)
```

# Challenge 2 - k-diff

## The solution

I approached this in a few different ways:

### Getting the filenames...

We can:
 1) Cheat - and create a hash of arrays;
 2) Use `opendir`/`readdir`/`closedir`;
 3) Use `blob '*/*'`;
 4) Use `<*/*>`.

Each have advantages/disadvantages:

 * the first doesn't require us to create files on disk for testing;
 * 2 allows you to find hidden file names but then you have to be careful with `.` & `..`. You have to join directory and filename to get the path
 * 3 & 4 are essentially the same and get all "folders/entries". You have to split the path to get the directory and filename.

The simplest approach is to use 3/4.

### Finding a complete list of different filenames

We collect a unique list of filenames, by putting them as the keys of a hash. We
could do this with a map - but it is useful to keep track of the number of times
we see each file.

```perl
  my( %directories, %filenames );
  for( sort <*/*> ) {
    my( $dir, $file ) = split m{/}, $_;
    $directories{$dir}=1;
    $file.='/' if -d $_;
    $filenames{ $file }{ $dir } = 1;
  }
  my @paths = sort keys %directories;
```

### Compute the length of the longest directory or filename

For the output we will want to pretty print it - and so need to work out the width
of the columns - this is a simple loop over the directories and filenames.
```perl
  my $length = 0;
  for ( @paths, keys %filenames ) {
    $length = length $_ if length $_ > $length;
  }
```
### Build templates for printing page horizontal line, sprintf table of heading/contents

We draw the horizontal line three times, so it is useful to keep a copy of it, we
in the code also need a template to sprintf the header and the body of the table.
So we generate these now. We use the length we computed above to compute the runs of
characters needed.

```perl
  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;

  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;
```

### Workout what to print and printing

This loops through the unique filenames we stored earlier. Then
for each filename we first check that it is present in all lists.
If it is we remove it and go onto the next filename. As we kept
counts of each filename this is as easy as checking that the
count is the same as the number of directories - this is the
first if in the loop.

We then loop through each column - if the filename is present
we display it o/w we display a blank string.

```perl
  for my $filename ( sort keys %filenames ) {
    next if @paths == keys %{$filenames{$filename}};
    my @columns;
    for (@paths) {
      if( exists $filenames{$filename}{$_} ) {
        push @columns, $filename;
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }
```

### Add the last line...

We print the bottom of the table:

```perl
say $1;
```

## The full code (with comments)

```perl
sub k_diff {
        ## my($l,%d,%u)=0;
  my( $length, %directories, %filenames )=0;

        ## /\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>
  for( sort <*/*> ) {
    my( $dir, $file ) = split m{/}, $_;
    $directories{$dir}=1;
    $file.='/' if -d $_;
    $filenames{ $file }{ $dir } = 1;
  }

        ## $l<length?$l=length:1for(my@p=sort keys%d),@_=keys%u
  my @paths = sort keys %directories;
  for ( @paths, keys %filenames ) {
    $length = length $_ if length $_ > $length;
  }

        ## say$a=join('-'x$l,('+--')x@p,"+\n"),sprintf($b="| %-${l}s "x@p."|\n",@p),$a,
  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;
  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;

        ## map({//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':''}@p:()}sort@_)
  for my $filename ( sort keys %filenames ) {
    next if @paths == keys %{$filenames{$filename}};
    my @columns;
    for (@paths) {
      if( exists $filenames{$filename}{$_} ) {
        push @columns, $filename;
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }

        ## $a
  say $HORIZONTAL_LINE;
}
```
## Obfurscated/Golf code...

I started with a "simple" compact version of the code and then came
discussions with Eliza on the Perl Programmers Facebook group and things
slowly got smaller. A few bytes at a time to the 259 bytes:

```perl
sub z{my($l,%d,%u)=0;/\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;$l<length?$l=length
:1for(my@p=sort keys%d),@_=keys%u;say$a=join('-'x$l,('+--')x@p,"+\n"),sprintf($b
="| %-${l}s "x@p."|\n",@p),$a,map({//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':
''}@p:()}sort@_),$a}
```

**or** if we "allow" return characters inside strings - this is 257 bytes of
perly goodness...

```perl
sub z{my($l,%d,%u)=0;/\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;$l<length?$l=length
:1for(my@p=sort keys%d),@_=keys%u;say$a=join('-'x$l,('+--')x@p,'+
'),sprintf($b="| %-${l}s "x@p.'|
',@p),$a,map({//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':''}@p:()}sort@_),$a}
```

**Notes**
 - We replace many of the loops and conditionals with `map`s and `_?_:_`
 - Where we use `$_` there are numerous function calls which use this when no
   parameter is passed - in this case `length`, `split`, `-d`.
 - When a "string" starts with a number than has a letter in it treats it as if
   to add a space between the number and the rest of the string so we can rewrite
   `1 for @array` as `1for@array`.
 - we don't need to do `sort blob '*/*'` or `sort <*/*>` as for all "current"
   versions of Perl we can assume that perl does this for us.
 - Rather than using `split /\//`, we use the match operator `/\//` in one place
   and `//` in another to split - the first half goes in `$`` and the second half
   in `$'`.
 - When using `//` this just copies `$_` into `$'`.
 - if you subtract a hash in scalar context then it subtracts the numbers of keys.
   Sp we can compute the number ot times a file is missing by doing `@p-%u`.
## Coda - taking the brakes off...

For ultimate compactness we can remove the function overhead off, turn off both
`strict` and `warnings`. We can reduce this to either 233 bytes (or 231 bytes)

```perl
/\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;$l<length?$l=length:1for(@p=sort keys%d),@_=keys%u;print$a=join('-'x$l,('+--')x@p,'+
'),sprintf($b="| %-${l}s "x@p.'|
',@p),$a,map({//;@p-%{$u{$'}}?sprintf$b,map{$' x$u{$'}{$_}}@p:()}sort@_),$a
```
This is the 233 byte version - we could reduce it to 231 bytes by replacing
`print` with `say` again... But ultimately that makes the execution more bytes.

Command line with `print`:

```perl
perl ch-2-ns.pl
```

Command line with `say` 

```perl
perl -M5.10.0 ch-2-ns.pl
```
So to save 2 bytes we use 9 more to run the command... of course you could just run it as a 1-liner on the command line (with the -E) but that would just be silly!
