#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(reduce);

sub decrypt_message {
    my @lines = @_;
    my $message_length = length($lines[0]);
    my $decrypted_message = "";

    for (my $i = 0; $i < $message_length; $i++) {
        my %counter;
        foreach my $line (@lines) {
            my $char = substr($line, $i, 1);
            $counter{$char}++;
        }
        my $most_common_char = reduce { $counter{$a} > $counter{$b} ? $a : $b } keys %counter;
        $decrypted_message .= $most_common_char;
    }

    return $decrypted_message;
}

my @repeated_message = (
    "P + 2 l ! a t o",
    "1 e 8 0 R $ 4 u",
    "5 - r ] + a > /",
    "P x w l b 3 k \\",
    "2 e 3 5 R 8 y u",
    "< ! r ^ ( ) k 0",
);

my $decrypted_message = decrypt_message(@repeated_message);
print "$decrypted_message\n";

