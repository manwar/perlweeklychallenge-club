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
# Challenge 2 - Z-diff

## Obfurscated/Golf code...

I started with a simple compact version of the code and then came
discussions with Eliza on Facebook and things slowly got smaller.

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
