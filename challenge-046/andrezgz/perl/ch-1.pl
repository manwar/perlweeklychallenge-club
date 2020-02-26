#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/
# Task #1
# Cryptic Message
# The communication system of an office is broken and message received
# are not completely reliable. To send message Hello,
# it ended up sending these following:
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
# Write a script to decrypt the above repeated message (one message repeated 6 times).
#
# HINT: Look for characters repeated in a particular position in all six messages received.

use strict;
use warnings;

my $msg = [
    [qw# P + 2 l ! a t o #],
    [qw# 1 e 8 0 R $ 4 u #],
    [qw# 5 - r ] + a > / #],
    [qw# P x w l b 3 k \ #],
    [qw# 2 e 3 5 R 8 y u #],
    [qw# < ! r ^ ( ) k 0 #],
];

my $msg_len = scalar @{$msg->[0]};
my @decrypted = ('?') x $msg_len;

for my $i (1 .. @{$msg}-1) {
    for my $j (0 .. $i-1) {
        for (0 .. $msg_len-1) {
            $decrypted[$_] = $msg->[$i]->[$_] if ($msg->[$i]->[$_] eq $msg->[$j]->[$_]);
        }
    }
    print @decrypted,"\n";
}

__END__
./ch-1.pl
????????
?????a??
P??l?a??
Pe?lRa?u
PerlRaku
