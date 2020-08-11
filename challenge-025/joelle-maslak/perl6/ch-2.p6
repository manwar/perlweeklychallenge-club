#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#
    
my Str:D  $LDEFAULT = 'HXUCZVAMDSLKPEFJRIGTWOBNYQ';
my Str:D  $RDEFAULT = 'PTLNBQDEOYSFAVZKGJRIHWXUMC';
my UInt:D $ZDEFAULT = 1;   # Start counting at 1
my UInt:D $NDEFAULT = 14;  # Start counting at 1

multi sub MAIN(
    'encrypt',
    Str:D  $text,
    Str:D  :$left   = $LDEFAULT,
    Str:D  :$right  = $RDEFAULT,
    UInt:D :$zenith = $ZDEFAULT,
    UInt:D :$nadir  = $NDEFAULT,
) {
    say endecrypt('encrypt', $text, $left, $right, $zenith, $nadir);
}

multi sub MAIN(
    'decrypt',
    Str:D  $text,
    Str:D  :$left   = $LDEFAULT,
    Str:D  :$right  = $RDEFAULT,
    UInt:D :$zenith = $ZDEFAULT,
    UInt:D :$nadir  = $NDEFAULT,
) {
    say endecrypt('decrypt', $text, $left, $right, $zenith, $nadir);
}

sub endecrypt(
    Str:D $mode,
    Str:D $text,
    Str:D $left   is copy,
    Str:D $right  is copy,
    Int:D $zenith is copy,
    Int:D $nadir  is copy,
) {
    die "Wheels not same size" if $left.chars ≠ $right.chars;
    my $size = $left.chars;

    # Normalize zenith and nadir to start at zero.
    $zenith--;
    $nadir--;

    # Get the input text
    my @input = $text.comb;
    my @output;

    for @input -> $char {
        my @left  = $left.comb;
        my @right = $right.comb;
   
        my $pos = $mode eq 'encrypt' ?? $right.index($char) !! $left.index($char);
        die "Letter ($char) not on wheels" unless $pos.defined;
        my $pletter = @right[$pos];
        my $eletter = @left[$pos];

        @output.push: $mode eq 'encrypt' ?? $eletter !! $pletter;

        # Permeate left wheel
        {
            # We need to rotate the left alphabet so ciphertext is the
            # ciphertext letter at the zenith.
            while @left[$zenith] ne $eletter {
                @left.append: @left.shift;
            }

            # We note the letter in the zenith + 1 position
            my $tmp = @left[($zenith + 1) % $size];

            # We move all the letters from the zenith + 2 to nadir left
            my $pos = ($zenith + 2) % $size;
            while $pos ≠ ($nadir + 1) % $size {
                @left[($pos - 1) % $size] = @left[$pos];
                $pos = ($pos + 1) % $size;
            }

            # We put the saved letter in the nadir position
            @left[$nadir] = $tmp;

            # Store the alphabet
            $left = @left.join;
        }

        # Permeate right wheel
        {
            # We put the plaintext letter at the zenith
            while @right[$zenith] ne $pletter {
                @right.append: @right.shift;
            }

            # Move the wheel one more position left
            @right.append: @right.shift;

            # We note the letter in the zenith + 2 position
            my $tmp = @right[($zenith + 2) % $size];

            # We move all the letters from the zenith + 3 to nadir left
            my $pos = ($zenith + 3) % $size;
            while $pos ≠ ($nadir + 1) % $size {
                @right[($pos - 1) % $size] = @right[$pos];
                $pos = ($pos + 1) % $size;
            }

            # We put the saved letter in the nadir position
            @right[$nadir] = $tmp;

            # Store the alphabet
            $right = @right.join;
        }
    }

    return @output.join;
}



