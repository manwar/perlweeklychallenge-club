#!/usr/bin/perl

use strict;
use warnings;

print "ch-2.pl (Version 1.0) PWC #42 Task #2: Balanced Brackets\n";

sub create_brackets {
	my ($nr) = @_;
	my $s;
	for( my $i=0; $i<=$nr; $i++ )  {
		my $br = int(rand(2));
		if($br) { $s .= ")"; } else { $s .= "("; }
	}
	return $s;
}

my $ok;
do {
	my $nr = int(rand(10));
	my $str = create_brackets($nr);
	$ok  = balanced_brackets($str);
	my $rs  = "NOT OK";
	$rs = "OK" if $ok;
	print $str, " - ", $rs, "\n";
} while( ! $ok );

sub balanced_brackets {
	my $str = shift;
	my $found = $str =~ s/\(\)//;
	my $ok;
	if($found) { 
		$ok = balanced_brackets($str);
		return $ok;
	}
	else { 
		if( $str=~/\(|\)/ ) { return 0; }
		else { return 1; }
	}
}

