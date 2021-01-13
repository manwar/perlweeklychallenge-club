# Solution by Abigail

## [Prime Sum](https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/#TASK1)

You are given a number `$N`. Write a script to find the minimum number
of prime numbers required, whose summation gives you `$N`.

For the sake of this task, please assume `1` is not a prime number.

### Example
~~~~
Input:
    $N = 9

Ouput:
    2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
    2 + 7 = 9.
~~~~

### Solutions
* [Perl](perl/ch-1.c)

## [Word Search](https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/#TASK2)

Write a script that takes two file names. The first file would
contain word search grid as shown below. The second file contains
list of words, one word per line. You could even use local dictionary
file.

Print out a list of all words seen on the grid, looking both
orthogonally and diagonally, backwards as well as forwards.

### Example
~~~~
B I D E M I A T S U C C O R S T
L D E G G I W Q H O D E E H D P
U S E I R U B U T E A S L A G U
N G N I Z I L A I C O S C N U D
T G M I D S T S A R A R E I F G
S R E N M D C H A S I V E E L I
S C S H A E U E B R O A D M T E
H W O V L P E D D L A I U L S S
R Y O N L A S F C S T A O G O T
I G U S S R R U G O V A R Y O C
N R G P A T N A N G I L A M O O
E I H A C E I V I R U S E S E D
S E T S U D T T G A R L I C N H
H V R M X L W I U M S N S O T B
A E A O F I L C H T O D C A E U
Z S C D F E C A A I I R L N R F
A R I I A N Y U T O O O U T P F
R S E C I S N A B O S C N E R A
D R S M P C U U N E L T E S I L
~~~~
#### Output

Found 54 words of length 5 or more when checked against the local
dictionary. You may or may not get the same result but that is fine.

aimed, align, antes, argos, arose, ashed, blunt, blunts, broad,
buries, clove, cloven, constitution, constitutions, croon, depart,
departed, enter, filch, garlic, goats, grieve, grieves, hazard,
liens, malign, malignant, malls, margo, midst, ought, ovary, parted,
patna, pudgiest, quash, quashed, raped, ruses, shrine, shrines,
social, socializing, spasm, spasmodic, succor, succors, theorem,
theorems, traci, tracie, virus, viruses, wigged

### Solutions
* [Perl](perl/ch-2.c)
