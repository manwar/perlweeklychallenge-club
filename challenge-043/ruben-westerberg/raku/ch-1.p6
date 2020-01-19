#!/usr/bin/env perl6

my %rings=(red=>9,green=>5,black=>0,yellow=>7,blue=>8);
my @y= %rings{<red green black yellow blue>}.map(11-*);
my @m=( [1,0,0,0,0],
        [1,1,0,0,0],
        [0,1,1,1,0],
        [0,0,0,1,1],
        [0,0,0,0,1]
);

#Perform Gauss-Jordan Elimination to solve.
my $x=solve(@m,@y);

my @labels= <red/green green/black black black/yellow yellow/blue>;
printf "%-15s%d\n",@labels[$_],$x[$_] for 0..@labels-1;

sub solve (@c, @y) {
	my @j=build(@c,@y);
	my $s=@c.elems;
	my @row;	
	for 0..$s-1 -> $p {
		my $v=@j[$p][$p];
		my $prow=@j[$p];
		for 0..$s-1 -> $r {
			@row:=@j[$r];
			next if $p==$r;
			my $d=@row[$p]/$v;
			for 0..$s -> $col {
				@row[$col]-=$d*$prow[$col];
			}
		}
	}
	@row[*-1]/=@row[*-2];
	@row[*-2]=1;
	backsub(@j);
}

sub build (@c, @y) {
	my @j;
	@j.push([|@c[$_],@y[$_]]) for 0..@c-1;
	@j;
}

sub backsub (@j) {
	my $s=@j;
	my @x=0 xx $s;
	for (0..$s-1).reverse -> $r {
		my $sum=0;
		my @row:=@j[$r];
		$sum+=@row[$_]*@x[$_]	for (0..$s-1);
		@x[$r]=@row[$s]-$sum;
	}
	@x;
}

