#!env perl6

# Perl Weekly Challenge 45
#
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/>
#
# Task 2
# Write a script that dumps its own source code.
# For example, say, the script name is ch-2.pl
# then the following command should returns nothing:
#
# $ perl ch-2.pl | diff - ch-2.pl



sub MAIN {
    .say for $*PROGRAM.lines;
}
