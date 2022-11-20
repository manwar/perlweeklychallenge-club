#!raku

# Perl Weekly Challenge 191

sub MAIN( Int $n where { 0 < $n <= 15 } ) {

    my $cute-counter = 0;
    for ( 1 .. $n ).List.permutations -> $current-list {
	my $is-cute = True;
	for 0 ..^ $current-list.elems -> $i {
	    $is-cute = False and last if $current-list[ $i ] !%% ( $i + 1 );
	}

	$cute-counter++ if $is-cute;

	$is-cute = True;
	for 0 ..^ $current-list.elems -> $i {
	    $is-cute = False and last if ( $i + 1 ) !%% $current-list[ $i ]  ;
	}

	$cute-counter++ if $is-cute;

    }
    $cute-counter.say;
}
