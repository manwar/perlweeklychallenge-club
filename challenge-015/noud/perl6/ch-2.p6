# Write a script to implement Vigenère cipher. The script should be able encode
# and decode. Checkout wiki page for more information.

# I restrict the Vigenere cipher only to lower case characters a, b, ..., z.
# Extending the cipher to upper case characters is possible, but makes this
# solution more tedious, because you need to check for extra cases and you
# have to define how to apply upper case keys to lower case characters and
# visa versa. For example what is 'a' + 'Z'?

sub cipher_apply(@inp_ords, @key_ords) {
    return (@inp_ords Z ({ @key_ords[$++ % *] } ... Inf)).map({
        if 'a'.ord <= $_[0] and $_[0] <= 'z'.ord {
            (($_[0] + $_[1] - 2 * 'a'.ord) % 26) + 'a'.ord
        } else {
            $_[0]
        }
    });
}

sub cipher_encrypt(Str $inp, Str $key) {
    return cipher_apply($inp.ords, $key.ords).chrs;
};

sub cipher_decrypt(Str $inp, Str $key) {
    return cipher_apply($inp.ords, $key.ords.map({ 2 * 'a'.ord - $_ })).chrs
};


multi MAIN('unit-test') {
    use Test;

    my $input = 'perl weekly challenge';
    my $key = 'fifteen';

    my $encrypted = cipher_encrypt($input, $key);
    my $decrypted = cipher_decrypt($encrypted, $key);

    $encrypted.say;
    $decrypted.say;

    is $input, $decrypted;
}
