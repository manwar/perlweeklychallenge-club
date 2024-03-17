#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
INIT $*RAT-OVERFLOW = FatRat;
use Test;

=begin comment
003-1
Create a script to generate 5-smooth numbers, whose prime divisors are less or equal to 5.
They are also called Hamming/Regular/Ugly numbers. For more information, please check this
wikipedia.
=end comment

my @Test =
        2,      3,      4,      5,      6,      8,      9,      10,     12,     15,
        16,     18,     20,     24,     25,     27,     30,     32,     36,     40,
        45,     48,     50,     54,     60,     64,     72,     75,     80,     81,
        90,     96,     100,    108,    120,    125,    128,    135,    144,    150,
        160,    162,    180,    192,    200,    216,    225,    240,    243,    250,
        256,    270,    288,    300,    320,    324,    360,    375,    384,    400,
        405,
;

sub is-five-smooth( Int $n -->Bool) {  return not so prime-factors($n).any > 5; }

constant @prime  = 2,3, { $_+=2; $_+=2 until .is-prime; $_; } … ∞;

constant @five-smooth = 2,3,4,5,6, { $_+=1; $_+=1 until is-five-smooth($_); $_ } … ∞;

sub prime-factors( $int -->Array) is export {
    my $n = $int;
    my @ret;
    my $ix = 0;
    while $n > 1 {
        my $candi = @prime[$ix];
        $ix++;
        next unless ( $n %% $candi );
        $ix = 0;
        $n ÷= $candi;
        @ret.push: $candi;
    }
    return @ret;
}

plan 1;
is @five-smooth[0..60], @Test, '@five-smooth[0..60]';
done-testing;

exit;
