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
Find all hex words...
```perl

```

## Some observations

### Longest words
```
 falsifiabilities  0x fa15 1f1a b111 71e5  (18,020,343,683,493,229,029)
 dissociabilities  0x d155 0c1a b111 71e5  (15,083,975,835,726,737,893)
 lactobacillaceae  0x 1ac7 0bac 111a ceae  ( 1,929,523,799,000,796,846)
```
Can add (if we include the g->9 mapping {could also do g->6}):
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

```perl
  my %directories;
  for my $path ( sort blob '*/*' ) {
    my( $dir, $file ) = split m{/}, $path;
    push @{ $directories{$dir} }, -d $path ? "$file/" : $file;
  }
```

### Finding a complete list of different filenames

```perl
  my @paths = sort keys %directories;
  my %filename_counts;
  for my $path ( @paths ) {
    $filename_counts{ $_ }++ for @{$directories{ $path }};
  }
```

### Build templates for printing page horizontal line, sprintf table of heading/contents

```perl
  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;

  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;
```

### Workout what to print:

``perl
  ## map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':
  ##   shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort keys%u)
  for my $filename ( sort keys %filename_counts ) {
    if( $filename_counts{ $filename } == @paths ) {
      shift @{$_} for values %directories;
      next;
    }
    my @columns;
    for (@paths) {
      if( @{$directories{$_}} && $directories{$_}[0] eq $filename ) {
        push @columns, shift @{$directories{$_}};
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }
```
## The full code (with comments)

```perl
sub z_diff {

  ## Declare variables

    ## my($l,%d,$F,@p,%u,$T,$H)=0;
  my( $length, %directories, %filename_counts )=0;

  ## Read all sub-directories containing files and store
  ## in data structure as a hash of ordered arrays
  ## For directories add a trailing slash...

    ## (@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for sort<*/*>;
  for my $pat ( sort blob '*/*' ) {
    my( $dir, $file ) = split m{/}, $path;
    push @{ $directories{$dir} }, -d $path ? "$file/" : $file;
  }

  ## Get out an ordered list of directories...

    ## $u{$_}++for map{@{$d{$_}}}@p=sort keys%d;
  my @paths = sort keys %directories;

  ## Find the length of the longest directory name, and
  ## keep a record of the number of times each filename
  ## has been seen (also gives list of all unique filenames)

  for my $path ( @paths ) {
    $filename_counts{ $_ }++ for @{$directories{$path}};
  }

  ## Now find the length of the longest filename or directory name
  ## This gives us the column widths for the pretty display...

    ## (length$_>$l)&&($l=length$_)for@p,keys%u;
  for ( @paths, keys %filename_counts ) {
    $length = length $_ if length $_ > $length;
  }

  ## Generate the ASCII code for a horizontal bar in the table
  ## and a template for sprintf for the rows of the table

  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;

  ## Draw the header {directory names} of the table....

    ## say for$H=join('-'x($l+2),('+')x(1+@p)),
    ##     sprintf($T='|'." %-${l}s |"x@p,@p),$H,
  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;

  ## Now draw the body - we loop through each of the unique filenames
  ## and see whether it is in all 4 columns (in which case we skip)
  ## otherwise we look to see which entries are present in each
  ## directory and show those....

    ## map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':
    ##   shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort keys%u)
  for my $filename ( sort keys %filename_counts ) {

    ## If we have seen the file in all directories - we remove
    ## it from all directory lists {and do nothing}

    if( $filename_counts{ $filename } == @paths ) {
      shift @{$_} for values %directories;
      next;
    }

    ## If we haven't we loop through the rows if
    ## the first entry is the file then we push it
    ## on the list to print {and remove it from the directory list}
    ## if not we just push an empty string to the
    ## list

    my @columns;
    for (@paths) {
      if( @{$directories{$_}} && $directories{$_}[0] eq $filename ) {
        push @columns, shift @{$directories{$_}};
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }

  ## Finally print out the bottom line

    ## $H
  say $HORIZONTAL_LINE;
}
```
## Obfurscated/Golf code...

I started with a "simple" compact version of the code and then came
discussions with Eliza on the Perl Programmers Facebook group and things
slowly got smaller. A few bytes at a time...

```perl
sub z{my($l,$F,%d,%u,$T,$H)=0;(@_=split'/'),push@{$d{$_[0]}},-d?"$_[1]/":$_[1]
for<*/*>;$u{$_}++for map{@{$d{$_}}}my@p=sort keys%d;$l<length?$l=length:1for@p,
@_=keys%u;say for$H=join('-'x($l+2),('+')x(1+@p)),sprintf($T="| %-${l}s "x@p.'|'
,@p),$H,map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':shift@{$d{$_}}}@p
:map{shift@{$d{$_}};()}@p}sort@_),$H}
```

**or** if we "allow" return characters inside strings - this is 351 bytes of
perly goodness...

```perl
sub x{my($l,$F,%d,%u,$T,$H)=0;(@_=split'/'),push@{$d{$_[0]}},-d?"$_[1]/":$_[1]
for<*/*>;$u{$_}++for map{@{$d{$_}}}my@p=sort keys%d;$l<length?$l=length:1for@p,
@_=keys%u;say$H=join('-'x($l+2),('+')x@p,'+
'),sprintf($T="| %-${l}s "x@p.'|
',@p),$H,map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':shift@{$d{$_}}
}@p:map{shift@{$d{$_}};()}@p}sort@_),$H}
```

**Notes**
 - Where we use `$_` there are numerous function calls which use this when no
   parameter is passed - in this case `length`, `split`, `-d`.
 - When a "string" starts with a number than has a letter in it treats it as if
   to add a space between the number and the rest of the string so we can rewrite
   `1 for $condition` as `1for$condition`.
 - we don't need to do `sort blob '*/*'` or `sort <*/*>` as for all "current"
   versions of Perl we can assume that perl does this for us.
