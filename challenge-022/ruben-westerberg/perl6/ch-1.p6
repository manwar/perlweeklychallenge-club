#!/usr/bin/env perl6

((1..*).grep: *.is-prime).map(->$p {
	state  @search;
	state $count =10;
	@search=@search.grep({$p-$_ <=6});	
	my @match=@search.grep({$p-6 == $_});
	if @match {
		put "Sexy Pair: @match[0],$p";
		last unless  --$count;
	}
	@search.push: $p;
});

