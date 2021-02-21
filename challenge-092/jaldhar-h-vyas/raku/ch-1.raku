#!/usr/bin/raku

sub isIsomorphic(Str $A, Str $B) {
    my SetHash of Str $seen;
    my %isomorphs;

    if ($A.chars != $B.chars) {
        return False;
    }

    for  $A.comb Z $B.comb -> ($a, $b) {
        if %isomorphs{$a}:exists {
            unless $b eq %isomorphs{$a} {
                return False;
            }
        } else {
            if $b ∉ $seen {
                %isomorphs{$a} = $b;
                $seen{$b}++;
            } else {
                return False;
            }
        }
    }

    return True;
}

sub MAIN(
    Str $A, #= a string
    Str $B  #= another string
 ) {
    say isIsomorphic($A, $B) ?? 1 !! 0;
}