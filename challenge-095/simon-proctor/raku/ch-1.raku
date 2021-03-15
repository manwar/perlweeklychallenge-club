#!/usr/bin/env raku

use v6;

#| Given a Palindromic number print 1
multi sub MAIN( Int() $N where { $N.Str.flip ~~ $N } ) { say 1 }

#| Given a non Palindromic number print 0
multi sub MAIN( $ ) { say 0 }
