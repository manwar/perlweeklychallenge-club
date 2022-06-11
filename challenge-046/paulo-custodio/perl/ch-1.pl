#!/usr/bin/env perl

# Challenge 046
#
# TASK #1
# Cryptic Message
# The communication system of an office is broken and message received are not
# completely reliable. To send message Hello, it ended up sending these following:
#
# H x l 4 !
# c e - l o
# z e 6 l g
# H W l v R
# q 9 m # o
# Similary another day we received a message repeatedly like below:
#
# P + 2 l ! a t o
# 1 e 8 0 R $ 4 u
# 5 - r ] + a > /
# P x w l b 3 k \
# 2 e 3 5 R 8 y u
# < ! r ^ ( ) k 0
# Write a script to decrypt the above repeated message (one message repeated 6
# times).
#
# HINT: Look for characters repeated in a particular position in all six messages
# received.

use Modern::Perl;

my @input =
    ("P+2l!ato",
     "1e80R\$4u",
     "5-r]+a>/",
     "Pxwlb3k\\",
     "2e35R8yu",
     "<!r^()k0");

say decode(@input);

sub decode {
    my(@input) = @_;
    my $decoded = "";
    for my $col (0..length($input[0])-1) {
        my %hist;
        my $max_letter = ''; my $max_count = 0;
        for my $row (@input) {
            my $letter = substr($row, $col, 1);
            $hist{$letter}++;
            if ($hist{$letter} > $max_count) {
                ($max_letter, $max_count) = ($letter, $hist{$letter});
            }
        }
        $decoded .= $max_letter;
    }
    return $decoded;
}
