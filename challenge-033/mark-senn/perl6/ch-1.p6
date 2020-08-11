#
# Perl Weekly Challenge - 033
# Task #1
#
# Mark Senn, http://engineering.purdue.edu/~mark
# November 5, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-033#task-1
#     Create a script that accepts one or more files specified on the
#     command-line and count the number of times letters appeared in the
#     files.
#
#     So with the following input file sample.txt
#         The quick brown fox jumps over the lazy dog.
#     the script would display something like:
#         a: 1
#         b: 1
#         c: 1
#         d: 1
#         e: 3
#         f: 1
#         g: 1
#         h: 2
#         i: 1
#         j: 1
#         k: 1
#         l: 1
#         m: 1
#         n: 1
#         o: 4
#         p: 1
#         q: 1
#         r: 2
#         s: 1
#         t: 2
#         u: 2
#         v: 1
#         w: 1
#         x: 1
#         y: 1
#         z: 1
#

# Run using Raku v6.d;
use v6.d;

# Tally the number of letters in all files specified on the command line.
my %count;
$*ARGFILES.lines.lc.comb(/<[a..z]>/).map({%count{$_}++});

# Print the tally.
%count.keys.sort.map({"$_: %count{$_}".say});
