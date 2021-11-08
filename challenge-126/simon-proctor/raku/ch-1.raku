#!/usr/bin/env raku

#| Given a number N give the count of all numbers between 1 and N inclusive that don't have a 1 in them
sub MAIN ( UInt \N ) {
    (1^..N).grep( { ! m/1/ } ).elems.say;
}
