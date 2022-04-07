#!/usr/bin/env perl

# Challenge 045
#
# TASK #1
# Square Secret Code
# The square secret code mechanism first removes any space from the original
# message. Then it lays down the message in a row of 8 columns. The coded message
# is then obtained by reading down the columns going left to right.
#
# For example, the message is “The quick brown fox jumps over the lazy dog”.
#
# Then the message would be laid out as below:
#
# thequick
# brownfox
# jumpsove
# rthelazy
# dog
# The code message would be as below:
#
# tbjrd hruto eomhg qwpe unsl ifoa covz kxey
# Write a script that accepts a message from command line and prints the
# equivalent coded message.

use Modern::Perl;

say encode("@ARGV");

sub encode {
    my($mess) = @_;
    $mess = lc($mess);
    $mess =~ s/\W//g;

    my @box;
    while ($mess ne '') {
        push @box, substr($mess,0,8);
        $mess = length($mess)>=8 ? substr($mess, 8) : '';
    }

    my $encoded = '';
    for my $col (0..7) {
        $encoded .= ' ' if $encoded ne '';
        for my $row (0 .. $#box) {
            if (length($box[$row]) >= $col) {
                $encoded .= substr($box[$row], $col, 1);
            }
        }
    }

    return $encoded;
}
