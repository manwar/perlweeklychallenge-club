#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Term::ANSIScreen qw(cls locate);
use Term::ReadKey 'GetTerminalSize';
use feature 'say';

# Write a script to display Digital Clock.
# Feel free to be as creative as you can when displaying digits.
# We expect bare minimum something like “14:10:11”.

my %alphabet = (
    1   => ["    11", "    11", "    11", "    11", "    11"], # This matrix holds the digits of our
    2   => ["222222", "    22", "222222", "22    ", "222222"], # digital clock. Each digit contains
    3   => ["333333", "    33", "333333", "    33", "333333"], # five sets of strings, which will be
    4   => ["44  44", "44  44", "444444", "    44", "    44"], # transposed into rows further down in
    5   => ["555555", "55    ", "555555", "    55", "555555"], # the code. They look confusing here
    6   => ["666666", "    66", "666666", "66  66", "666666"], # because the code is indented to be
    7   => ["777777", "    77", "    77", "    77", "    77"], # more compact. See below the __END__
    8   => ["888888", "88  88", "888888", "88  88", "888888"], # section for a more readable example
    9   => ["999999", "99  99", "999999", "    99", "999999"], # of what this looked like before I
    0   => ["000000", "00  00", "00  00", "00  00", "000000"], # ran perltidy on it.
    ':' => ["      ", "  ::  ", "      ", "  ::  ", "      "],
);

# This is our main loop. Note while () is equivalent to while (1).
while () {

    # clear the screen after every frame
    cls();

    # Grab the screen size and half it so we can start from (roughly) the middle.
    # Doing that in the loop means we can handle resizing of the terminal during run time.
    my ($x, $y) = map { int $_ / 2 } GetTerminalSize();

    my @letters = split //, localtime->hms;

    # Each row is represented by a column above in the hash with our alphabet.
    foreach my $row (0 .. 4) {

        # Our "digits" are 6 characters wide and there are 8 of them, plus 1 space after
        # all but the last. That gives us 62 characters in total, so we move half of that
        # to the left from the centre of the screen to start writing.

        # The "digits" are 5 characters high, so we start off at 2 characters above the
        # middle of the screen.
        locate($y + ($row - 2), $x - 31);
        say map { $alphabet{$_}->[$row] . q{ } } @letters;
    }

    # I wonder how long this needs to run until it gets out of sync...
    sleep 1;
}

__END__
"    11",
"    11",
"    11",
"    11",
"    11"

"222222",
"    22",
"222222",
"22    ",
"222222"