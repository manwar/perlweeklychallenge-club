#!/usr/bin/env raku

sub infix:<≈≈>(Str \x, Str \y) is equiv(&[eq]) returns Bool {
    x.ords.sort == y.ords.sort
}

sub MAIN(Str \a, Str \b, Str \c) {
    say +(a ~ b ≈≈ c)
}
