# Solutions by Asbigail
## [Chowla Numbers](https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK1)

Write a script to generate first 20 Chowla Numbers, named after,
Sarvadaman D. S. Chowla, a London born Indian American mathematician.
It is defined as:

    C(n) = (sum of divisors of n) - 1 - n

### Output

    0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

### Solutions

### Blog


## [Four Squares Puzzle](https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK2)

You are given four squares as below with numbers named `a`, `b`,
`c`, `d`, `e`, `f`, `g`.

              (1)                    (3)
        ╔══════════════╗      ╔══════════════╗
        ║              ║      ║              ║
        ║      a       ║      ║      e       ║
        ║              ║ (2)  ║              ║  (4)
        ║          ┌───╫──────╫───┐      ┌───╫─────────┐
        ║          │   ║      ║   │      │   ║         │
        ║          │ b ║      ║ d │      │ f ║         │
        ║          │   ║      ║   │      │   ║         │
        ║          │   ║      ║   │      │   ║         │
        ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
                   │       c      │      │      g      │
                   │              │      │             │
                   │              │      │             │
                   └──────────────┘      └─────────────┘

Write a script to place the given unique numbers in the square box
so that sum of numbers in each box is the same.

### Example

~~~~
Input: 1,2,3,4,5,6,7

Output:

    a = 6
    b = 4
    c = 1
    d = 5
    e = 2
    f = 3
    g = 7

    Box 1: a + b = 6 + 4 = 10
    Box 2: b + c + d = 4 + 1 + 5 = 10
    Box 3: d + e + f = 5 + 2 + 3 = 10
    Box 4: f + g = 3 + 7 = 10
~~~~

### Solutions

### Blog

