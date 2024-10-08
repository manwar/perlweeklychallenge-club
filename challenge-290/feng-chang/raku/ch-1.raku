#!/bin/env raku

unit sub MAIN(*@ints);

@ints = +«@ints;
put so @ints[^+@ints].grep(-> \a { 2*a (elem) @ints (-) a });
