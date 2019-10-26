#
# Perl Weekly Challenge - 030
# Task #1
#
# Mark Senn, http://engineering.purdue.edu/~mark
# October 19, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-030#task-1
#     Write a script to list dates for Sunday Christmas
#     between 2019 and 2100.  For example, 25 Dec 2022 is Sunday.
#

# Perl 6 is in the process of being renamed Raku.
# Run using Raku v6.d;
use v6.d;

sub MAIN()
{
    for (2019..2100) -> $year  {
        (Date.new(day =>25, month=>12, year=>$year).day-of-week == 7)
            and  say "25 Dec $year";
    }
}

# The program printed:
#     25 Dec 2022
#     25 Dec 2033
#     25 Dec 2039
#     25 Dec 2044
#     25 Dec 2050
#     25 Dec 2061
#     25 Dec 2067
#     25 Dec 2072
#     25 Dec 2078
#     25 Dec 2089
#     25 Dec 2095
