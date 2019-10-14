Solutions by James Smith.

Sorry these are such nice golf questions they had to be golfed..

# Challenge 1 - sum to 12

I've included two solutions to this as the question was slighlty ambiguous

The first solution is for a strictly increasing sequence of numbers {no dupes}
```
perl -E 'say map{$a=$_;map{join","," $a",$_,12-$a-$_}$a+1..5.5-$a/2}1..3'
```

The second is for a series of sequences which can allow duplicates
```
perl -E 'say map{$a=$_;map{join","," $a",$_,12-$a-$_}$a..6-$a/2}1..4'
```

In both cases we have used shortest loops - possible...

# Challenge 2 - Christmas on a Sunday?

Solving the actual problem - we need to work out which days have 5*year/4 mod 7 to be zero, so just use a simple grep, to keep the code sort we use "@{[ ]}" which at 7 bytes is one byte shorter than join" ",

```
perl -E 'say"@{[grep{!(int(5*$_/4)%7)}2019..2099]}"'
```

We can extend this to every year (since the Gregorian calendar was introduced) by subtracting
int year/100 & adding int year/400...

```
perl -E 'say"@{[grep{6==(int(5*$_/4)-int($_/100)+int$_/400)%7}2019..3e3]}"'
```

## Lengths of scripts:
All four scripts come in at: 269 bytes - the shortest two solutions come in at 131 bytes
```
| script | Bytes |
| --- | ---: |
| ch1.sh | 73 |
| ch1-duplicates.sh | 69 |
| ch2.sh | 52 |
| ch2-better.sh | 75 |
```
