#!/usr/bin/env perl
#
use strict;
use warnings;
use List::Util qw<all none any>;

my @pokemon= do { open my $fh, "<", "../pokemon.txt"; <$fh>};
chop @pokemon;
#@pokemon=@pokemon[0..49];

my @stack;
my ($max, $node)=(0, undef);

my $root={name=>"", parent=>undef, depth=>0};
push @stack, $root;

while (@stack){
	my @result= process(shift @stack);
	push @stack, @result;
}

print join ",", ppath($node);
sub process {
	my $tree=shift;
	my @path=ppath($tree);
	my @next=grep { !defined($tree->{parent}) || (substr($_, 0,1) eq substr($tree->{name},-1,1 ))} @pokemon;
	@next=sort grep { my $n=$_; none {$n eq $_ } @path } @next;			
	if (@next && $tree->{depth} > $max) {
		#print "We have max \n";
		$max= $tree->{depth};
		$node=$tree;
		print "@path\n";
	}
	
	map {{name=>$_, parent=>$tree, depth=>$tree->{depth}+1} } @next;
}


sub ppath {
	my $node=shift;
	my @res;
	 while (defined $node->{parent}) {
		my $n=$node;
		$node=$node->{parent};
		unshift @res, $n->{name};
	}
	@res;
}
