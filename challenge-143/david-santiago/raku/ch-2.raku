#!/usr/bin/env raku

# bipronic numbers:
# Numbers of the form x*(x+1) * y*(y+1) ("bipronics") with x and y nonnegative integers. 

sub MAIN (Int $n){
    for (1..$n/2.ceiling) -> $a {
	for (1..$a) -> $b {
	    if $a*($a+1) * $b*($b+1) == $n {
		say "Yes";
		return;
	    }
	}
    }  
    say "No";
}
