#!/usr/bin/env raku

use v6;

#| Given a year output the Chinese year
sub MAIN(
    Int \year #= Western year
) {
    cycle()[(1924-year).abs % 60].say;
}

sub cycle() {
    my @elements = lazy gather {
	my $i = 0;
	my @els = <Wood Wood Fire Fire Earth Earth Metal Metal Water Water>;
	loop {
	    take @els[$i];
	    $i++;
	    $i = 0 if $i > @els.end;
	}
    };

    return ( @elements Z,
    ( |<Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig> xx 5 ) ).map( *.join(" ") );    
}
