Solutions by James Smith.

# Challenge 1 - Counting letters

There are two ways to solve this -> split and count or using tr... one is short code - one is longer - but much faster.

## Version 1 - short code

Uses lc, split and grep to count the elements and put them in a hash... looping through each file a line at a time with <>

```
use feature 'say';
use strict;
my %T = map { $_=>0 } foreach 'a'..'z';
while(<>) {
  $T{$_}++ foreach grep { /[a-z]/ } split m{}, lc $_;
}

say "$_: $T{$_}" foreach 'a'..'z';
```

Running this over 13Mbytes of PHP takes approximately 6.5 seconds...

## Version 2 - faster code

Now counting letters in a string is quickest using the tr or y operator - as this requires the number of characters
changed. Without using eval you can't unfortunately sub in a variable into the pattern unlike with m/s... So we
either need to use string eval (which is evIl) or manually replicate the loop - $T{'a'} =~ y/aA/aA/ etc - in this
code... Note we set $/ to undef so that we slurp the whole file in in one go (to improve performance of using tr)
and less modifications to the %T hash...

```
use feature 'say';
$/=undef;

while(<>) {
  $T{'a'} += y/aA/aA/;
  $T{'b'} += y/bB/bB/;
..
..
  $T{'y'} += y/yY/yY/;
  $T{'z'} += y/zZ/zZ/;
}

say $_,': ',$T{$_}||0 foreach 'a'..'z';

```
OK - so didn't want to type 26 lines so used this one liner to do it for me!

```
perl -E 'say "  \$t{'"'"'$_'"'"'} += y/$_".uc($_)."/$_".uc($_)."/;" foreach "a".."z";' 
```

This now runs in approxy 0.25 seconds a big improvement...

## Version 3 - nicer output...

The version 3 code just expands the version 2 code - but creates a "histogram" to show the distribution (and at the same time formats the totals better)

```
a : 584193 : ##########################
b : 108267 : ####
c : 287124 : #############
d : 272798 : ############
e : 877936 : ########################################
f : 209371 : #########
g : 152944 : ######
h : 200641 : #########
i : 546465 : ########################
j :  15133 :
k :  50049 : ##
l : 326976 : ##############
m : 214631 : #########
n : 438874 : ###################
o : 436059 : ###################
p : 282120 : ############
q :  19825 :
r : 551144 : #########################
s : 552344 : #########################
t : 724711 : #################################
u : 260233 : ###########
v :  68882 : ###
w :  80759 : ###
x :  57019 : ##
y : 115201 : #####
z :  11021 :
```

# Challenge 2 - multiplication square...

Again going to extend the challenge to make this generic (in case someone wants a different version)

Hidden in the solution above was getting the number of digits for a number (so we can format the totals) - we do this again to get the size of the left hand column and the main table columns.

```
my $sl = int(log($N)/log(10)+1);     ## Get size of integer $N - defines the width of the LH column
my $sr = int(2*log($N)/log(10)+1);   ## Get size of $N squared - defines the width of other columns
```
and we use this to tweak the formats and the padding/line drawing elements!
```
#!/usr/bin/perl

use strict;
use feature 'say';

## This solves more than the puzzle - but thought I would make it more generic!

## This gets the size of the square that we want to display...

my $N  = shift =~ s{\D}{}gr || 11;        ## Default to 11 - but use first parameter as size of square!
my @R  = 1..$N;                           ## Create a "range array" - we use this 4 times!!!

## Get width of columns for use in the renderer..

my $sl = int( log($N) / log(10) + 1);     ## Get size of integer $N - defines the width of the LH column
my $sr = int( 2 * log($N) / log(10) + 1); ## Get size of $N squared - defines the width of other columns
my $fl = sprintf ' %%%dd |', $sl;         ## Create a template for the first column..
my $fr = sprintf ' %%%dd', $sr;           ## .... and for the other columns!

## Finally we render - make a use of sprintf with the templates and '$' x $ to generate padding

say ' ' x $sl, 'x |',                                               ## Header (LH side)
    map          { sprintf $fr, $_ }                            @R; ##        (column headers)
say join '-', '-' x $sl, '-+',                                      ## Separator (LH side)
    map          { '-' x $sr }                                  @R; ##           (RH side)
say sprintf( $fl, $a=$_ ),                                          ## Body of table (LH headers)
    map          { $a>$_ ? ' ' x ($sr+1) : sprintf $fr, $a*$_ } @R  ##               (content of row)
    foreach                                                     @R;
```
