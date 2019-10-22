#!/usr/bin/perl6


sub permute_left($key, $text) {
    my @left_key = $key.comb;

    while @left_key[0] ne $text {
        @left_key = @left_key.rotate;
    }

    @left_key.splice(1, 13, @left_key[2 .. 13, 1].flat);

    return @left_key.join;
}

sub permute_right($key, $text) {
    my @right_key = $key.comb;

    while @right_key[0] ne $text {
        @right_key = @right_key.rotate;
    }
    @right_key.rotate;

    @right_key.splice(2, 12, @right_key[3 .. 13, 2].flat);

    return @right_key.join;
}

multi sub MAIN (
    Bool :$d!,              #= decrypt a message
    Str :$l!,
    Str :$r!,
    Str :$m!
) {
    my @message = $m.comb;
    my $left_key = $l;
    my $right_key = $r;
    my @decrypted;

    for @message -> $letter {
        my $i = $left_key.index: $letter;
        my $ciphertext = $right_key.substr($i, 1);
        @decrypted.push($ciphertext);
        $left_key = permute_left($left_key, $letter);
        $right_key = permute_right($right_key, $ciphertext);
    }

    @decrypted.join.say;        
}

multi sub MAIN (
    Bool :$e!,              #= encrypt a message
    Str :$l!,               #= left key for encryption/decryption
    Str :$r!,               #= right key for encryption/decryption
    Str :$m!                #= message to encrypt/decrypt
) {
    my @message = $m.comb;
    my $left_key = $l;
    my $right_key = $r;
    my @encrypted;

    for @message -> $letter {
        my $i = $right_key.index: $letter;
        my $ciphertext = substr $left_key, $i, 1;
        @encrypted.push($ciphertext);
        $left_key = permute_left($left_key, $ciphertext);
        $right_key = permute_right($right_key, $letter);
    }

    @encrypted.join.say;
}
