#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<uniq first>;
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
	@$dict= uniq @$in;# ((0..9),('A'..'Z'),('a'..'z'));
	push @$in, undef;
	for (@$in) {
		state $symbol="";
		my $next=$_;#shift;
		$symbol.=$next if defined $next;
		state $prev="";
		my $s=first {$symbol eq $_} @$dict; 
		unless ( $s and $next) {
			push @$dict, $symbol;
			push @$out, first {$prev eq $$dict[$_]} 0..@$dict-1;
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
