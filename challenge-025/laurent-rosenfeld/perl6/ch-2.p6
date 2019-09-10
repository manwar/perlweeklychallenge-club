use v6;
subset UcStr of Str where /^<[A..Z]>+$/;

sub permute-alphabets (UcStr $left is copy, UcStr $right is copy, UInt $pos) {
    $left = substr($left, $pos) ~ substr $left, 0, $pos;
    $left = substr($left, 0, 1) ~ substr($left, 2, 12)
            ~ substr($left, 1, 1) ~ substr $left, 14;

    $right = substr($right, $pos+1) ~ substr $right, 0, $pos+1;
    $right = substr($right, 0, 2) ~ substr($right, 3, 11)
             ~ substr($right, 2, 1) ~ substr $right, 14;
    return ($left, $right);
}

sub run_tests {
    use Test;
    plan 4;
    my $left  = 'HXUCZVAMDSLKPEFJRIGTWOBNYQ';
    my $right = 'PTLNBQDEOYSFAVZKGJRIHWXUMC';
    my $position = index $right, 'A';
    my ($newleft, $newright) = permute-alphabets $left, $right,
        $position;
    is $newleft, 'PFJRIGTWOBNYQEHXUCZVAMDSLK',
        "Left alphabet: $newleft";
    is $newright, 'VZGJRIHWXUMCPKTLNBQDEOYSFA',
        "Right alphabet: $newright";
    my $plaintext = "WELLDONEISBETTERTHANWELLSAID";
    my $ciphertext = encipher($plaintext, $left, $right);
    is $ciphertext, 'OAHQHCNYNXTSZJRRHJBYHQKSOUJY',
        "Testing enciphering: $ciphertext";
    my $deciphered = decipher($ciphertext, $left, $right);
    is $deciphered, $plaintext, "Roundtrip: $deciphered";
}

sub encipher (UcStr $plaintext, UcStr $left is copy, UcStr $right is copy) {
    my $ciphertext = "";
    for $plaintext.comb -> $let {
        my $position = index $right, $let;
        $ciphertext ~= substr $left, $position, 1;
        ($left, $right) = permute-alphabets $left, $right,
            $position;
    }
    return $ciphertext;
}

sub decipher (UcStr $ciphertext, UcStr $left is copy, UcStr $right is copy) {
    my $plaintext = "";
    for $ciphertext.comb -> $let {
        my $position = index $left, $let;
        $plaintext ~= substr $right, $position, 1;
        ($left, $right) = permute-alphabets $left, $right,
            $position;
    }
    return $plaintext;
}

multi MAIN () {
    run_tests;
}
multi MAIN (Str $mode, Str $text, Str $left, Str $right) {
    if $mode.lc eq 'encipher' {
        say encipher $text.uc, $left.uc, $right.uc;
    } elsif $mode.lc eq 'decipher' {
        say decipher $text.uc, $left.uc, $right.uc;
    } else {
        die "Invalid mode $mode: must be 'encipher' or 'decipher'.\n";
    }
}
