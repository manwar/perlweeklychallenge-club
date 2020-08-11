#!/usr/bin/env perl

use warnings;
use strict;

my $decode=$ARGV[0]//undef;
my @alpha= ("a".."z","A".."Z"," ", qw(? ! . : >));
my @alpha1=@alpha;
my @alpha2=@alpha;
$|=1;
while (<STDIN>) {
	chomp;	
	for (split "", $_) {
		print chaochiper(\@alpha1,\@alpha2, $_, $decode);	
	}
	print "\n";
}
sub chaochiper {

	my ($a1,$a2,$c,$decode)=@_;
	my ($p,$ct);	
	if ($decode) {
		$p= (grep { $$a2[$_] eq $c } 0..@$a2-1)[0];
		$ct=$$a1[$p];
	}
	else {
		$p= (grep { $$a1[$_] eq $c } 0..@$a1-1)[0];
		$ct=$$a2[$p];
	}
	
	push @$a1, splice @$a1, 0, $p+1;
	push @$a2, splice @$a2, 0, $p;

	{
		use integer;
		splice(@$a1, @$a1 / 2,0, splice(@$a1,2,1));
		splice(@$a2, @$a2 / 2,0 ,splice(@$a2,1,1));
	}
	$ct;
}
