#!/usr/bin/env raku

use v6;

#| Given a string and a simple pattern see if the string matches the pattern 
multi sub MAIN(
    Str $S, #= String to check
    Str $P, #={ Pattern to match : 
? - Matches a single character : 
* - Matches any number of characters
}
) {
    my $regex = generate-regex( $P );
    say $S.match($regex) ?? 1 !! 0;
}

sub generate-regex( $P ) {
    my @chars = [ '^', |$P.comb.map(
		      -> $c {
			  given $c {
			      when "*" { ".*" };
			      when "?" { "." };
			      default { "'$c'" };
			  }
		      }
		  ), '$' ];
    return rx/<{@chars.join(" ")}>/;		  
}
