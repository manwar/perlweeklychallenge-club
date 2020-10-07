#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# tested with: raku jeongoon/raku/ch-1.raku perlraku perlrakuperlrakuperlraku

=begin unfolded

sub MAIN( *@a where @a.elems == 2 ) {
    (1..[gcd] @a».chars).
    map( ->\k {
               my \w = @a[0].substr(^k); # a possible base (w)ord
               #          `-> it doesn't matter which words are in use
               next if any @a.map({
                                .indices(w).elems
                                        !=
                                .chars / k
                                } );
               w # take
           } ).join(", ").put
}

=end unfolded

# https://dev.to/jeongoon/weekly-challenge-081-task-1-422l
# folded
sub MAIN(*@a){put (1..[gcd] @a».chars).map(->\k{my \w=@a[0].substr(^k);next if any @a.map({.indices(w)!= .chars/k});w})}

=begin off-the-challenge

# credit: markus-holzer
# thank you :-)

#sub MAIN(*@a){put ([\~] @a[0].substr(^ [gcd] @a».chars)).grep(->\w{all @a.map({.indices(w)==.chars/w.chars})})}
sub MAIN(*@a){put ([\~] @a.min).grep(->\w{all @a.map({.indices(w)==.chars/w.chars})})}

=end off-the-challenge
