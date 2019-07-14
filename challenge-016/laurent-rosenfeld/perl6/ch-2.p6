use v6;
use Digest::SHA;
use Test;
plan 4;

my @base58 = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".comb;
    # https://en.wikipedia.org/wiki/Base58

my %base58 = map { @base58[$_] => $_}, 0 .. 57;
sub b58toraw (Str $address) {
    my UInt $num = 0;
    my $i = 0;
    for $address.comb.reverse -> $letter {
        $num += %base58{$letter} * 58**$i++;
    }
    my @bytes = $num.base(16).fmt("%050s").comb(2) ;
    my $buff = Buf.new(map {.fmt("%02s").parse-base(16)}, @bytes);
    return $buff;
}

sub check($address) {
    return False if $address ~~ /<[O0lI]>/;
    my $raw = b58toraw $address;
    my $four-last-bytes = $raw.subbuf(21, 4);
    my $double-digest = sha256( sha256 $raw.subbuf(0, 21));
    return  True if $double-digest.subbuf(0, 4) eq $four-last-bytes;
    False;
}
ok  check("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"), "Correct Address 1";
nok check("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVw2"), "Incorrect Address 1";
ok  check("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), "Correct Address 2";
nok check("3k98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"), "Incorrect Address 2";
