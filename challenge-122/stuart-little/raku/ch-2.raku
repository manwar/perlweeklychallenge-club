#!/usr/bin/env raku
use v6;

# run <script> <score>

sub comp($nr,$bd) {
    my @tab=[[[],],];
    for (1..$nr) -> $n {
	my @item=[,];
	for (1..$bd) -> $i {
	    (@tab.elems >= $i) && do {
		my @suppPrev = @tab.[*-$i].map( -> @ar { ($i, |@ar).Array }).Array;
		@item.push(|@suppPrev);
	    };
	}
	@tab.elems >= $bd && do { shift @tab };
	@tab.push(@item);
    }
    return @tab.[*-1];
}

for (@(comp(@*ARGS[0].Int,3))) { .say }
