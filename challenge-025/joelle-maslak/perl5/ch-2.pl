#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;

MAIN: {
    my $left   = 'HXUCZVAMDSLKPEFJRIGTWOBNYQ';
    my $right  = 'PTLNBQDEOYSFAVZKGJRIHWXUMC';
    my $zenith = 1;
    my $nadir  = 14;
    GetOptions(
        "left=s" => \$left,
        "right=s" => \$right,
        "zenity=i" => \$zenith,
        "nadir=i" => \$nadir,
    );
    if ( @ARGV != 2 ) {
        die("Invalid parameters, provide command (encrypt|decrypt) and text at a minimum");
    }

    my $cmd = shift(@ARGV);
    my $text = shift(@ARGV);

    if ($cmd ne 'encrypt' and $cmd ne 'decrypt') {
        die "Invaid command, must be encrypt or decrypt";
    }

    say endecrypt($cmd, $text, $left, $right, $zenith, $nadir);
}

sub endecrypt(
    $mode,
    $text,
    $left,
    $right,
    $zenith,
    $nadir,
) {
    die "Wheels not same size" if length($left) != length($right);
    my $size = length($left);

    # Normalize zenith and nadir to start at zero
    $zenith--;
    $nadir--;

    # Get the input text
    my (@input) = split //, $text;
    my @output;

    for my $char (@input) {
        my (@left) = split //, $left;
        my (@right) = split //, $right;

        my $pos = $mode eq 'encrypt' ? index($right, $char) : index($left, $char);
        die "Letter ($char) not on wheel" unless $pos >= 0;
        my $pletter = $right[$pos];
        my $eletter = $left[$pos];

        push @output, $mode eq 'encrypt' ? $eletter : $pletter;

        # Permeate left wheel
        do {
            # We need to rotate the left alphabet so ciphertext is the
            # cyphertext letter at the zenith
            while ($left[$zenith] ne $eletter) {
                push @left, shift @left;
            }

            # We note the letter in the zenith + 1 position
            my $tmp = $left[($zenith + 1) % $size];

            # We move all the letters from the zenith + 2 to nadir left
            my $pos = ($zenith + 2) % $size;
            while ($pos != ($nadir + 1) % $size) {
                $left[($pos - 1) % $size] = $left[$pos];
                $pos = ($pos + 1) % $size;
            }

            # We put the saved letter in the nadir position
            $left[$nadir] = $tmp;

            # Store the alphabet
            $left = join '', @left;
        };

        # Permeate right wheel
        do {
            # We put the plaintext letter at the zenith
            while ($right[$zenith] ne $pletter) {
                push @right, shift @right;
            }

            # Move the wheel one more position left
            push @right, shift @right;

            # We note the letter in the zenith + 2 position
            my $tmp = $right[($zenith + 2) % $size];

            # We move all the letters from the zenith + 3 to nadir left
            my $pos = ($zenith + 3) % $size;
            while ($pos != ($nadir + 1) % $size) {
                $right[($pos - 1) % $size] = $right[$pos];
                $pos = ($pos + 1) % $size;
            }

            # We put the saved letter in the nadir position
            $right[$nadir] = $tmp;

            # Store the alphabet
            $right = join '', @right;
        };
    }

    return join("", @output);
}

