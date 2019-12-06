#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $m_item = 5;
my %comb;
my $def;
map{ $def .= $_ }1..$m_item;
map{ $comb{$_} = 0 }(1..$m_item);
for my $f (1..$m_item) {
	my @sel = grep length $_ == $f , sort keys %comb;
	foreach my $i ( @sel ) {
		my $index = index $def, substr $i, -1;
		my $sub = substr $def, $index + 1;
		map{ $comb{"$i$_"} = 0 }split //, $sub;
	}
}

my %packages = ( 
	1 => { weight => 1, amount => 1},
	2 => { weight => 1, amount => 2},
	3 => { weight => 2, amount => 2},
	4 => { weight => 12, amount => 4},
	5 => { weight => 4, amount => 10}
);

my $max_weight = 15;
my %res; 

foreach my $key ( keys %comb ) {
	my ( $weight, $amount );
	map{ $weight += $packages{$_}{'weight'}; $amount += $packages{$_}{'amount'} }split //, $key;

	$res{$key} = { w=>$weight, a=>$amount } if $weight <= $max_weight;
}

my $tkey;
foreach ( sort { $res{$b}{'a'} <=> $res{$a}{'a'} || $res{$b}{'w'} <=> $res{$a}{'w'}} keys %res ) {
	$tkey = $_;
	last;
}

my ($skey) = $tkey =~ tr/12345/RBGYP/r;
print "$skey => amount = £$res{$tkey}{'a'}, weight =  $res{$tkey}{'w'}kg\n";

