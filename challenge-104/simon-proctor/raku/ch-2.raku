#!/usr/bin/env raku

subset Difficulty of IntStr where 1 <= * <= 10;

#| Play a Game of Nim
sub MAIN(
    Difficulty $iq = IntStr.new(5,"5"), #= The intelligence of the AI (1 is dumb, 10 is unbeatable)
) {
    
    my $first;
    while ( $first !~~ any(<y Y n N>) ) {
	$first = prompt("Would you like to go first? [Y/n] ") || "y";
    }
    my $pieces = 12;

    while ( $pieces > 0 ) {
	say "$pieces {"#" x $pieces}";
	given $first.uc {
	    when "Y" {
		my $how-many;
		while ($how-many !~~ any(1,2,3)) {
		    $how-many = prompt("How many would you like (1,2,3)? ");
		}
		$pieces -= $how-many;
		$first = "N";
	    }
	    when "N" {
		my $dumb = (1..10).pick;
		my $choice = ai($iq.Int, $dumb, $pieces);
		say "I take $choice";
		$pieces -= $choice;
		$first = "Y";
	    }
	}
    }
    given $first.uc {
	when "Y" {
	    say "I Won! Or course";
	}
	when "N" {
	    say "Well done puny human";
	}
    }
}

multi sub ai($iqin, $dumb, $pieces) {
    if ( $dumb > $iqin ) {
	my $pick = (1..3).pick;
	return $pieces < $pick ?? $pieces !! $pick;
    } else {
	given $pieces {
	    when 12|8|4 { return 1 }
	    when 11|7|3 { return 3 }
	    when 10|6|2 { return 2 }
	    when 9|5|1 { return 1 };
	}
    }
}
