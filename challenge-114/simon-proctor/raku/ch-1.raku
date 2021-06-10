#!/usr/bin/env raku

#| Find the nest highest integer that's a palindrome
sub MAIN( Int $N ) {
    ($N^..*).first( { $_ ~~ $_.flip } ).say
}
