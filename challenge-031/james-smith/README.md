Solutions by James Smith.

Sorry these are such nice golf questions they had to be golfed..

# Challenge 1 - Christmas on a Sunday?

Solving the actual problem - we need to work out which days have 5*year/4 mod 7 to be zero, so just use a simple grep, to keep the code sort we use "@{[ ]}" which at 7 bytes is one byte shorter than join" ",

```
perl -E 'say"@{[grep{!(int(5*$_/4)%7)}2019..2099]}"'
```

We can extend this to every year (since the Gregorian calendar was introduced) by subtracting
int year/100 & adding int year/400...

```
perl -E 'say"@{[grep{6==(int(5*$_/4)-int($_/100)+int$_/400)%7}2019..3e3]}"'
```

# Challenge 2 - sum to 12

I've included two solutions to this as the question was slighlty ambiguous, as not sure if duplicates are allowed. Note the second requirement of one of the numbers being even is irrelevant as for three numbers to add to 12 then at least 1 must me even - 3 odds would add to an odd number...

The first solution is for a strictly increasing sequence of numbers {no dupes}
```
perl -E 'say map{$a=$_;map{" $a,$_,".(12-$a-$_)}$a+1..5.5-$a/2}1..3'
```

The second is for a series of sequences which can allow duplicates
```
perl -E 'say map{$a=$_;map{" $a,$_,".(12-$a-$_)}$a..6-$a/2}1..4'
```

In both cases we have used shortest loops - possible...

## Lengths of scripts:
All four scripts come in at: 259 bytes - the shortest two solutions come in at 116 bytes (pushing into a single script is just 107 bytes);

| Script | Bytes | Notes |
| :---: | ---: | :--- |
| ch1.sh | 52 | Solve the actual problem of 2019-2099 - doesn't have issues with centuries |
| ch1-better.sh | 75 | Include the century rules |
| ch2.sh | 68 | Initial version of script with strictly increasing numbers |
| ch2-duplicates.sh | 64 | Version of script which allows duplicates |

