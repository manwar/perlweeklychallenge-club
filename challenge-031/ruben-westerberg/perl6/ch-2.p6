#!/usr/bin/env perl6
use MONKEY-SEE-NO-EVAL;
my $name=@*ARGS[0]//"var"~1000.rand.Int;
my $value=@*ARGS[1]//1.rand;
{
	put "Using Module/eval";
	module D {
		EVAL "our \$$name=\"$value\"";
	}
	put $D::($name);
	put "Variable name: $name Value: {$D::($name)}";
}

put "";

{
	put "Using Hash";
	my %h;
	%h{$name}=$value;
	put "Variable name: $name Value: %h{$name}";

}
