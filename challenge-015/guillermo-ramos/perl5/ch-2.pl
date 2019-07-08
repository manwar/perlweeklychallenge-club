#!/usr/bin/env perl
#
# Write a script to implement Vigenère cipher.
# (https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher)
################################################################################

use strict;
use warnings;

sub vigenere {
    # Direction: encrypt (1) vs decrypt (-1)
    my ($direction, $text, $key) = @_;

    chomp $text;

    my ($A, $Z) = (ord("a"), ord("z"));
    my $OFFSET = $Z - $A + 1;

    foreach my $i (0 .. length($text)-1) {
        # Only process alpha characters (gets lowered before)
        next unless substr($text, $i, 1) =~ /^[a-zA-Z]$/;

        # Add/subtract the key character to the corresponding one in text
        my $ord = ord(lc(substr($text, $i, 1))) +
            $direction * (ord(substr($key, $i % length($key), 1)) - $A);

        # Adjust if character got out of alpha range
        $ord -= $OFFSET if $ord > $Z;
        $ord += $OFFSET if $ord < $A;

        substr($text, $i, 1) = chr($ord);
    }
    return $text;
}

sub encrypt { vigenere(1, @_); }
sub decrypt { vigenere(-1, @_); }

my $USAGE = "Usage: $0 (enc|dec) key\n";
my $MODE = shift or die $USAGE;
my $KEY = shift or die $USAGE;

my $f;
if ($MODE eq "enc") {
    $f = \&encrypt;
} elsif ($MODE eq "dec") {
    $f = \&decrypt;
} else {
    die $USAGE;
}

while (<STDIN>) {
    print $f->($_, $KEY), "\n";
}
