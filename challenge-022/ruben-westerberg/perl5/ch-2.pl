#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

# implement LZW 
my @input=split "", $ARGV[0]//"TOBEORNOTTOBEORTOBEORNOT";
my @decoded;
my @encoded;
my @symbols;

print "Input: ",join("",@input),"\n";
encode(\@symbols, \@input ,\@encoded);

print "Encoded: ",join(",",@encoded),"\n";

decode(\@symbols,\@encoded,\@decoded);

print "Decoded: ",join("",@decoded),"\n";



sub encode {
	my ($dict,$in, $out)=@_;
	@$dict= ((0..9),('A'..'Z'),('a'..'z'));
	push @$in, undef;
	for (@$in) {
		state $symbol="";
		state $count= @$dict;
		my $next=$_;#shift;
		$symbol.=$next if defined $next;
		state $prev="";
		my $s=(grep {$symbol eq $_} @$dict)[0];
		my $res;
		if (defined $s and  $next) {
			#found existing keep adding
			$res=undef;
		}
		else {
			#add new symbol
			#$$dict{$symbol}=$count++;
			push @$dict, $symbol;
			$res=(grep {$prev eq $$dict[$_]} 0..@$dict-1)[0];
			push @$out, $res;
			$symbol=substr $symbol, -1;
		}
		$prev=$symbol;
	}
}


sub decode {
	my ($dict,$in,$out)=@_;
	for (@$in) {
		push @$out, @$dict[$_];
	}
}
