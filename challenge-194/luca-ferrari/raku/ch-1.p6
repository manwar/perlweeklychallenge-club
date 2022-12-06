#!raku

# Perl Weekly Challenge 194

sub MAIN( Str $what ) {

    given ( $what ) {
	when ( / ^ \? \d ':' \d ** 2 $ / )     { 2.say and exit  }
	when ( / ^ <[01]> \? ':' \d ** 2 $ / ) { 9.say and exit  }
	when ( / ^ 2 \? ':' \d ** 2 $ / )      { 3.say and exit  }
	when ( / ^ \d ** 2 ':' \? \d $ / )     { 5.say and exit  }
	when ( / ^\d ** 2 ':' \d \? $ / )      { 9.say and exit  }
    }
}
