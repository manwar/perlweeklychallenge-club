#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# We are considering the following cases to determine the next
# palindromic integer:
#
#  - If the number consists of just 9s, we add 2 to the number, resulting
#    in 100001, where we have 1 less 0 than we had 9s.
#  - Else, split the number into three parts: (NNNN)(M)(PPPP), where
#    the first and third part are of equal lengths, and M is zero or one
#    digit (zero digits of the input number is of even length, else the
#    middle part is just one digit).
#
#    Define nnnn as the reverse of NNNN,
#           pppp as the reverse of PPPP,
#           QQQQ as NNNN + 1,
#           qqqq as the reverse of QQQQ,
#           m = M + 1 (if M is one digit long)
#
#    Now:
#        - If nnnn > PPPP, then result is "NNNNMnnnn", else
#        - If M is one digit long, then:
#               - If M < 9,  then the result is "NNNNmnnnn", else
#               - the result is "QQQQ0qqqq", else
#        - The result is "QQQQqqqq".
#

while (<>) {
    chomp;
    if (/^9+$/) {
        say $_ + 2;
        next;
    }

    #
    # Split the number into parts 2 equal parts, with a middle part
    # of at most one digit.
    #
    my $part1 = substr $_, 0, int length ($_) / 2;
    my $part2 = substr $_,    int length ($_) / 2,  length ($_) % 2;
    my $part3 = substr $_,    int length ($_) / 2 + length ($_) % 2;

    if (reverse ($part1) > $part3) {
        say $part1, $part2, scalar reverse ($part1);
    }
    else {
        if (length $part2) {
            if ($part2 == 9) {
                $part1 ++;
                $part2 = 0;
            }
            else {
                $part2 ++;
            }
        }
        else {
            $part1 ++;
        }
        say $part1, $part2, scalar reverse ($part1);
    }
}
