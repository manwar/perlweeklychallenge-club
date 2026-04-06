Perl Weekly Challenge 171
https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

Task 1: Abundant Number
Submitted by: Mohammad S Anwar
Write a script to generate first 20 Abundant Odd Numbers.

According to wikipedia,


A number n for which the sum of divisors s(n) > 2n, or, equivalently, the sum of proper divisors (or aliquot sum) s(n) > n.


For example, 945 is the first Abundant Odd Number.

Sum of divisors:
1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975


Task 2: First-class Function
Submitted by: Mohammad S Anwar
Create sub compose($f, $g) which takes in two parameters $f and $g as subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x))


e.g.

$f = (one or more parameters function)
$g = (one or more parameters function)

$h = compose($f, $g)
$f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
