#!/usr/bin/perl

for (my $i = 0; $i <= 50; $i++) {

	print "Decimal $i = Octal "; 
	printf("%o\n",$_)for "$i";
}
