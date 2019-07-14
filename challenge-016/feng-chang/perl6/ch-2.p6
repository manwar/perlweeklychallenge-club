#!/bin/env perl6

# digit '0', capital 'I', 'O', lower case 'l' ared not allowed
# lower case 'o', and digit '1' are used
my @A = ('1'..'9', 'A'..'H', 'J'..'N', 'P'..'Z', 'a'..'k', 'm'..'z').flat;
my %H = @A.antipairs;

sub MAIN(Str $key-str = '1AGNa15ZQXAZUgFiqJ2i7Z2DPU2J6hW62i') {
    die "key should start with 1 or 3\n" unless substr($key-str, 0, 1) eq '1'|'3';

    my Buf $key-buf = long2short($key-str);
    say all($key-buf.subbuf(21, 4).list) ∈  cksum($key-buf.subbuf(0, 21)).Set ?? 'ok' !! 'not ok';
}

# convert 34-byte bitcoin address to standard 25-byte form
sub long2short(Str $key-str) returns Buf {
    my $n = 0;
    for $key-str.comb -> $c {
        die "invalid character '$c'\n" unless %H{ $c }:exists;
        $n *= 58;
        $n += %H{ $c };
    }

    my Buf $key-buf = Buf.new(0 xx 25);
    loop (my $i = 24; $i >= 0 && $n > 0; --$i) {
        $key-buf[$i] = $n % 256;
        $n div= 256;
    }
    die "address too long: n = $n\n" if $n;

    return $key-buf;
}

sub cksum(Buf $key-buf) {
    use Digest::SHA256::Native;
    return sha256(sha256($key-buf)).subbuf(0, 4);
}
