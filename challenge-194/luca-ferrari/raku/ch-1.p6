#!raku

# Perl Weekly Challenge 194

sub MAIN( Str $what ) {

    given ( $what ) {
	when ( / ^ \? \d ':' \d ** 2 $ / ) { 2.say and exit }
	when ( / ^ \d \? ':' \d ** 2 $ /
	       || / ^ \d ** 2 ':' \? \d $ / ) { 5.say and exit }
	when ( / ^\d ** 2 ':' \d \? $ / )  { 9.say and exit }
    }
    # exit if $what !~~ / \? /;
    # 2.say if $what ~~ / ^ \? \d ':' \d ** 2 $ /;
    # 5.say if $what ~~ / ^ \d \? ':' \d ** 2 $ / || $what ~~ / ^ \d ** 2 ':' \? \d $ / ;
    # 9.say if $what ~~ / ^\d ** 2 ':' \d \? $ /;
}
