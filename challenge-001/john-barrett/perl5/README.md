As published on https://perlweeklychallenge.org/blog/a-new-week-a-new-challenge/ <br/>
Submissions demonstrated here using [Reply](https://metacpan.org/pod/Reply).

> Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’ is found in the string.

I didn't write a script so I fail this challenge already.

```
0> my $foo = 'Perl Weekly Challenge'
$res[0] = "Perl Weekly Challenge"
1> $foo =~ s/e/E/g;
$res[1] = 5
2> $foo
$res[2] = "PErl WEEkly ChallEngE"
3> 
```

> Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20. However, any number divisible by 3 should be replaced by the word ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both divisible by 3 and 5 become ‘fizzbuzz’.

I don't remember where I saw this, but it is my favourite Perl5 FizzBuzz:

```
4> { no strict; no warnings; map { (fizz)[$_%3].(buzz)[$_%5]||$_ } 1..20 }
$res[4] = [
    [0]  1,
    [1]  2,
    [2]  "fizz",
    [3]  4,
    [4]  "buzz",
    [5]  "fizz",
    [6]  7,
    [7]  8,
    [8]  "fizz",
    [9]  "buzz",
    [10] 11,
    [11] "fizz",
    [12] 13,
    [13] 14,
    [14] "fizzbuzz",
    [15] 16,
    [16] 17,
    [17] "fizz",
    [18] 19,
    [19] "buzz"
]
```

Since I didn't write that myself I also fail the second part of the challenge. Not going well. Let's see...

```
$ perl -MAcme::FizzBuzz -e '1' | head -n 20 | tr '[:upper:]' '[:lower:]'
1
2
fizz
4
buzz
fizz
7
8
fizz
buzz
11
fizz
13
14
fizzbuzz
16
17
fizz
19
buzz
```

 There!

