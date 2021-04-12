#!/usr/bin/env raku


multi sub MAIN ( $ ) is hidden-from-USAGE { say 0 }

#| Given a list of numbers print the largest distance between them when sorted
multi sub MAIN ( *@a where *.elems > 1 ) {
    @a.sort.rotor(2 => -1).map( { $^a[1] - $^a[0] } ).max.say;    
}
