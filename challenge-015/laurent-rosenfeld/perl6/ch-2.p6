use v6;

subset Letter of Str where .chars == 1;

sub create-code (Str $passwd) {
    # Converts password to a list of numeric codes
    # where 'a' corresponds to a shift of 1, etc.
    return $passwd.comb(1).map: {.ord - 'a'.ord + 1}
}
sub rotate-one-letter (Letter $letter, Int $shift) {
    # Converts a single letter and deals with cases
    # where applying the shift would get out of range
    constant $max = 255;
    my $shifted = $letter.ord + $shift;
    $shifted = $shifted > $max ?? $shifted - $max !!
        $shifted < 0 ?? $shifted + $max !!
        $shifted;
    return $shifted.chr;
}
sub rotate-msg (Str $msg, @code) {
    # calls rotate-one-letter for each letter of the input message
    # and passes the right shift value for that letter
    my $i = 0;
    my $result = "";
    for $msg.comb(1) -> $letter {
        my $shift = @code[$i];
        $result ~= rotate-one-letter $letter, $shift;
        $i++;
        $i = 0 if $i >= @code.elems;
    }
    return $result;
}
sub encode (Str $message, @key) {
    rotate-msg $message, @key;
}
sub decode (Str $message, @key) {
    my @back-key = map {- $_}, @key;
    rotate-msg $message, @back-key;
}
multi MAIN (Str $message, Str $password) {
    my @code = create-code $password;
    my $ciphertext = encode $message, @code;
    say "Encoded cyphertext: $ciphertext";
    say "Roundtrip to decoded message: {decode $ciphertext, @code}";
}
multi MAIN ("test") {
    use Test; # Minimal tests for providing an example
    plan 6;
    my $code = join "", create-code("abcde");
    is $code, 12345, "Testing create-code";
    my @c = create-code "password";
    for <foo bar hello world> -> $word {
        is decode( encode($word, @c), @c), $word,
            "Round trip for $word";
    }
    my $msg = "One small step for man, one giant leap for mankind!";
    my $ciphertext = encode $msg, @c;
    is decode($ciphertext, @c), $msg,
        "Message with spaces and punctuation";
}
