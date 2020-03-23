# Ryan Thompson

## Week 052 Solutions

### Task 1 › Stepping Numbers

 * [Perl](perl/ch-1.pl)
 * [Raku](raku/ch-1.p6)

### Task 2 › Lucky Winner

 * [Perl](perl/ch-2.pl)
 * [Raku](raku/ch-2.p6)

## Blogs

 * [Week 052 › Stepping Numbers](http://ry.ca/2020/03/stepping-numbers/)
 * [Week 052 › Lucky Winner](http://ry.ca/2020/03/lucky-winner/)

***

## Documentation for `perl/ch-2.pl`


# NAME

ch-2.pl - Lucky Winner Simulator 9000

# SYNOPSIS

```
ch-2.pl [options] [algorithm1 algorithm2 ...]
ch-2.pl --human=<cpu_algorithm>
ch-2.pl --help
```

# OPTIONS

```
--count=<iter>     Play <iter> games                   Default: 1000
--coins=<N>        Every game uses <N> coins           Default: 8
--maxcoin=<N>      Maximum coin value                  Default: 200
--help             Full help page
--human=<cpu_alg>  Human vs CPU, CPU uses <cpu_alg>
--seed=<N>         Use specific random number seed (integer)
--verbose          Enable extra output
--noverbose        Disable extra output
```

# ALGORITHMS

- `human` › Human input. Only available with `--human` option.

- `bozo` › Real stupid algorithm; chooses left or right randomly.

- `worst` › Somehow even stupider. Always picks lowest option.

- `greedy` › Greedy algorithm. Always picks highest option, but doesn't look
  ahead.

- `ahead1`, `ahead3`, `ahead5` › Looks ahead **1**, **3**, or **5** turns, and
  picks the option that maximizes (**my\_score** - **their\_score**)

# AUTHOR

Ryan Thompson <rjt@cpan.org>
