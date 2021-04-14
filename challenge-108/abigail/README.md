# Solutions by Asbigail
## [Locate Memory](https://perlweeklychallenge.org/blog/perl-weekly-challenge-108/#TASK1)

Write a script to declare a variable or constant and print it's
location in the memory.

### Solutions
* [C](c/ch-1.c)
* [Fortran](fortran/ch-1.f90)
* [Go](go/ch-1.go)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)

### Blog


## [Bell Numbers](https://perlweeklychallenge.org/blog/perl-weekly-challenge-108/#TASK2)

Write a script to display top 10 Bell Numbers. Please refer to
[wikipedia page](https://en.wikipedia.org/wiki/Bell_number) for
more informations.

### Example
* `B_0 = 1`, as you can only have one partition of zero element set
* `B_1 = 1`, as you can only have one partition of one element set {a}.
* `B_2 = 2`, `{a}{b}`, `{a,b}`.
* `B_3 = 5`, `{a}{b}{c}`, `{a,b}{c}`, `{a}{b,c}`, `{a,c}{b}`, `{a,b,c}`.
* `B_4 = 15`, `{a}{b}{c}{d}`, `{a,b,c,d}`, `{a,b}{c,d}`, `{a,c}{b,d}`,
              `{a,d}{b,c}`, `{a,b}{c}{d}`, `{a,c}{b}{d}`, `{a,d}{b}{c}`,
              `{b,c}{a}{d}`, `{b,d}{a}{c}`, `{c,d}{a}{b}`, `{a}{b,c,d}`,
              `{b}{a,c,d}`, `{c}{a,b,d}`, `{d}{a,b,c}`

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [Befunge-93][befunge-93/ch-2.bf93]
* [Perl](perl/ch-2.pl)

### Blog

