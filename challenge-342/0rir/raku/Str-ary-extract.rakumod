use v6.d;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»

unit module Str-ary-extract;

multi sub postcircumfix:<[ ]>( Str:D $a, Int:D $b -->Str:D) is export {
    die "Index value must be from 0 to $a.chars.pred() inclusive."
        unless 0 ≤ $b < $a.chars;
    $a.substr( $b,1)
}

multi sub postcircumfix:<[ ]>( Str:D $a, Range:D $b -->Str:D) is export {
    die "Index values must be from 0 to $a.chars.pred() inclusive."
        if $b.min < 0 or $a.chars ≤ $b.max;
    $a.substr( $b.min..$b.max)
}

# XXX Empty Str or type object???  Using '' with a guess of greater convenience.
multi sub grep( &code, Str:D $a -->Str) is export {
    say 'aAa';
    my Str $ret = '';
    for 0 .. $a.chars.pred -> \i {
         $ret ~= $a[i] if code($a[i]);
    }
    $ret;
}
