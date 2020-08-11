#!/usr/bin/perl6
use v6;

use Test;

# 25.2 Create script to implement Chaocipher https://en.wikipedia.org/wiki/Chaocipher

my $startLeftWheel="HXUCZVAMDSLKPEFJRIGTWOBNYQ";
my $startRightWheel="PTLNBQDEOYSFAVZKGJRIHWXUMC";
constant zenith=0; # 1st position
constant nadir=13; # 14th position

sub encipher($plain) {
    my @l=$startLeftWheel.comb;
    my @r=$startRightWheel.comb;
    my $cipher;

    for $plain.comb -> $i {
        # locate letter in right wheel
        my $j = indexOf(@r,$i);
        # cipher it with left wheel
        $cipher~=@l[$j];
        @l=permuteLeftWheel(@l,$j);
        @r=permuteRightWheel(@r,$j);
    }
    return $cipher;
}

sub decipher($cipher) {
    my @l=$startLeftWheel.comb;
    my @r=$startRightWheel.comb;
    my $plain;

    for $cipher.comb -> $i {
        # locate letter in left wheel
        my $j = indexOf(@l,$i);
        # decipher it with right wheel
        $plain~=@r[$j];
        @l=permuteLeftWheel(@l,$j);
        @r=permuteRightWheel(@r,$j);
    }

    return $plain;
}

sub indexOf(@wheel, $i) {
    my Int $index=0;
    for @wheel -> $j {
        last if $j eq  $i;
        $index++;
    }
    return $index;
}

sub permuteLeftWheel(@l is copy,$j) {
    # 1. Shift the entire left alphabet cyclically so the ciphertext letter just enciphered is positioned at the zenith
    @l=@l.rotate($j);

    # 2. Extract the letter found at position zenith+1 (i.e., the letter to the right of the zenith), taking it out of the alphabet, temporarily leaving an unfilled ‘hole’.
    my $extract = @l[zenith+1];
    @l[zenith+1]=" ";

    # 3. Shift all letters in positions zenith+2 up to, and including, the nadir (zenith+13), moving them one position to the left.
    @l[zenith+1..nadir-1]=@l[zenith+2..nadir];

    # 4. Insert the just-extracted letter into the nadir position (i.e., zenith+13).
    @l[nadir]=$extract;

    return @l;
}

sub permuteRightWheel(@r is copy,$j) {
    # 1. Shift the entire right alphabet cyclically so the plaintext letter just enciphered is positioned at the zenith.
    # 2. Now shift the entire alphabet one more position to the left (i.e., the leftmost letter moves cyclically to the far right), moving a new letter into the zenith position.
    @r=@r.rotate($j+1);

    # 3. Extract the letter at position zenith+2, taking it out of the alphabet, temporarily leaving an unfilled ‘hole’.
    my $extract=@r[zenith+2];
    @r[zenith+2]=" ";

    # 4. Shift all letters beginning with zenith+3 up to, and including, the nadir (zenith+13), moving them one position to the left.

    @r[zenith+2..nadir-1]=@r[zenith+3..nadir];

    # 5. Insert the just-extracted letter into the nadir position (zenith+13).
    @r[nadir]=$extract;

    return @r;
}

multi MAIN("encipher", Str $plaintext where  m:i/ <[A..Z]>* /  ) {
    say encipher($plaintext.uc) if $plaintext.chars>0;
}

multi MAIN("decipher", Str $ciphertext where  m:i/ <[A..Z]>* /  ) {
    say decipher($ciphertext.uc) if $ciphertext.chars>0;
}

multi MAIN("test") {
    is encipher("WELLDONEISBETTERTHANWELLSAID"),"OAHQHCNYNXTSZJRRHJBYHQKSOUJY","encipher ok";
    is decipher("OAHQHCNYNXTSZJRRHJBYHQKSOUJY"),"WELLDONEISBETTERTHANWELLSAID","decipher ok";
    done-testing;
}
