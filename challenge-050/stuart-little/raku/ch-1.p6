#!/usr/bin/env perl6
use v6;

sub mrg(@a) {
    my @srta = @a.sort;
    given @a.elems {
	when * <= 1 { @srta }
	default {
	    (@srta[0;1] < @srta[1;0])
	    ?? (@srta[0], |mrg(@srta[1..*]))
	    !! (((@srta[0;0],max(@srta[0;1],@srta[1;1])), |@srta[2..*]).&mrg)
	}
    }
}

say @*ARGS.map(*.split(',').map(*.Int)).&mrg

# run as <script> <space-separated intervals with comma-separated endpoints; e.g. <script> 2,7 3,9 10,12 15,19 18,22
