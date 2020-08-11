#!/usr/bin/env perl6

# implement LZW 
my @input=comb "", @*ARGS[0]//"TOBEORNOTTOBEORTOBEORNOT";
my @decoded;
my @encoded;
my @symbols;

print "Input: ",join("",@input),"\n";

encode(@symbols, @input ,@encoded);

print "Encoded: ",join(",",@encoded),"\n";

decode(@symbols,@encoded,@decoded);

print "Decoded: ",join("",@decoded),"\n";


sub encode (@dict, @in, @out) {
	@dict= @in.unique; 	#Create initial dictionary
	push @in, Any;		#Add end marker to input	
	for @in {
		state $symbol="";
		my $next=$_;
		$symbol~=$next if $next.defined;
		state $prev="";
		my $s=first {$symbol eq $_}, @dict;	#Search for existing
		unless $s.defined and $next.defined {
			push @dict, $symbol;
			push @out, @dict.first: {$prev eq $_ },:k;
			$symbol=substr $symbol, *-1;
		}
		$prev=$symbol;
	}
}


sub decode(@dict, @in, @out) {
	for @in {
		push @out, @dict[$_];
	}
}
