#!/usr/bin/env perl6
#
my @pokemon="../pokemon.txt".IO.lines;
#@pokemon=@pokemon[^50];
my %root=(name=>Nil, parent=>Nil, depth=>0);
my $max=0;
my $node=Nil;
my @stack.push: %root;
my $stopFlag=False;
my $channel=Channel.new;
my $counter=0;
signal(SIGINT).tap({$stopFlag=True});

while @stack and !$stopFlag {
	@stack.append: process @stack.shift;
}

say pokepath($node);
	
sub process(%tree) {
	my $next:=@pokemon.grep: {!%tree<parent>.defined||.starts-with: %tree<name>.substr: *-1,1 };
	my @path=pokepath(%tree);
	$next:= sort keys $next (-) @path;
	if %tree<depth> > $max {
		$max=%tree<depth>;
		$node=%tree;
		say @path;
	}

	$next.map({
		%( name=>$_, parent=>%tree, depth=>%tree<depth>+1 );
	}) ;
}
sub pokepath($node is copy) {
	reverse gather while $node<parent>.defined {
		take $node<name>;
		$node=$node.<parent>;
	}
}
