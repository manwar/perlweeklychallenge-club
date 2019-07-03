#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

my $decode;
GetOptions("decode"=>\$decode);
die "please specify a key\n" unless $ARGV[0];
$|=1;

my @alpha=("a".."z","A".."Z", " ", qw<? ! . :>);
my @a=0..@alpha-1;
my @k;
for my $c (split "", $ARGV[0]) {
	push @k, grep { $c eq $alpha[$_] } @a;
}

my $f=$decode? 1 : -1;
while (<STDIN>) {
	my (@in, @out);
	for my $c (split "") {
		push @in, grep { $c eq $alpha[$_]} @a;
	}
	my $i=0;
	for my $c (@in) {
		push @out, ($c+$f*$k[$i++])%@a;
		$i%=@k;
	}
	print @alpha[@out],"\n";	
}

