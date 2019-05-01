#!/usr/bin/env perl
#
my $string=join ',', @ARGV;

my @a=split ',' , $string;
my %bag;
foreach (@a) {
	$bag{$_}++;
}
my @k1= sort { $a <=> $b} keys %bag;
my @k2= @k1; push @k2, shift @k2;
my @p;
for (my $i=0; $i<=$#k1; $i++) {
	if (abs($k2[$i]-$k1[$i]) > 1 ) {
		push @p,$i;
		push @p ,$i+1;
	}
}
unshift @p, 0;
pop @p;
my @out;
for (my $i=0; $i<$#p; $i+=2) {
	my $a=$k1[$p[$i]];
	my $b=$k1[$p[$i+1]];
	my $val= $a-$b == 0? $a: "$a-$b";
	push @out, $val;
}
print (join ",", @out);
print "\n";
	
