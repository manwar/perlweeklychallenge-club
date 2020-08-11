#!/usr/bin/env perl6
#Compute Eulers number to the nth term
#
my $degree=@*ARGS[0]//10;
my $i=1;
my $sum=FatRat.new(1);
while ($i <= $degree ) {
	state $fac=FatRat.new(1);
	$sum+=1/($fac*=$i++);
}
put "Eulers constant to $degree terms:\n%s\n", $sum.base-repeating(10).join("");
