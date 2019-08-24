#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

# implement LZW 
my @symbols= 'A'..'Z';
my @indexes;
for (split "","TOBEORNOTTOBEORTOBEORNOT") {
	my $res=encode(\@symbols, $_);
	if ($res) {
		push @indexes, $res
	}
}
my $res=encode(\@symbols, $_);
if ($res) {
	push @indexes, $res
}
print join ",",@indexes;

for (@indexes) {
	print decode(\@symbols,$_),"\n";
}
sub encode {
	state $symbol="";
	my $dict=shift;
	state $count= @$dict;
	my $next=shift;
	$symbol.=$next if defined $next;
	print "Symbol: ",$symbol,"\n";
	state $prev="";
	print "Prev: ",$prev,"\n";
	my $s=(grep {$symbol eq $_} @$dict)[0];
	print "$s\n";
	print "$symbol\n";
	my $res;
	if (defined $s and  $next) {
		#found existing keep adding
		$res=undef;
	}
	else {
		#add new symbol
		print "New symbol $symbol\n";
		#$$dict{$symbol}=$count++;
		push @$dict, $symbol;
		$res=(grep {$prev eq $$dict[$_]} 0..@$dict-1)[0];
		$symbol=substr $symbol, -1;
	}
	$prev=$symbol;
	$res;
}


sub decode {
	my $dict=shift;
	my $code=shift;	
	@$dict[$code];
}
