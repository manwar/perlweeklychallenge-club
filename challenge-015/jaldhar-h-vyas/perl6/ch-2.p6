#!/usr/bin/perl6

sub decrypt(@key, $keylength, %tabulaRecta, $c) {
    state $i = 0;

    return chr(ord('A') + index(%tabulaRecta{@key[$i++ % $keylength]}, $c));
}

sub encrypt(@key, $keylength, %tabulaRecta, $c) {
    state $i = 0;

    return substr(%tabulaRecta{@key[$i++ % $keylength]}, ord($c) - ord('A'), 1);
}

sub makeSquare {
    return (0 .. 25)
        .map({ ['A' .. 'Z'].rotate($_).join; })
        .map({ $_.substr(0, 1) => $_});
}

sub prep {
    my ($string) = @_;

    $string = uc $string;
    $string ~~ s:g/<-[A .. Z]>//;

    return $string;
}

sub vigenère($k, $m, &op) {
    my %tabulaRecta = makeSquare();
    my @key = prep($k).comb;
    my $keylength = @key.elems;
    my @message = prep($m).comb;

    @message
        .map({ op(@key, $keylength, %tabulaRecta, $_) })
        .join
        .say;
}

multi sub MAIN (
    Bool :$d!,              #= decrypt a message
    Str :$k!,
    Str :$m!
) {
    vigenère($k, $m, &decrypt);
}

multi sub MAIN (
    Bool :$e!,              #= encrypt a message
    Str :$k!,               #= key for encryption/decryption
    Str :$m!                #= message to encrypt/decrypt
) {
    vigenère($k, $m, &encrypt);
}
