#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

my $decode;
GetOptions("decode"=>\$decode);
die "Please specify a key\n" unless $ARGV[0];
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
	my $i=0;
	chomp;
	for my $c (split "") {
		my $in =(grep { $c eq $alpha[$_]} @a)[0];
		push @out, ($in+$f*$k[$i++])%@a;
		$i%=@k;
	}
	print @alpha[@out],"\n";	
}

