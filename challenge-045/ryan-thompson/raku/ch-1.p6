#!/usr/bin/env perl6

# ch-1.p6 - Square code
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Str $plaintext = 'The quick brown fox jumps over the lazy dog' ) {
    say encode($plaintext, 8);
}

#| Encode plaintext according to the Square Secret Code definition
#  $width is by default chosen to give a "square" result
sub encode( Str $plain, Int $width = $plain.chars.sqrt.Int ) {
    my @s;
    $plain.lc.subst(/\s/,'',:g).comb.kv.map: { @s[$^i % $width] ~= $^str };

    @s.join(' ')
}
