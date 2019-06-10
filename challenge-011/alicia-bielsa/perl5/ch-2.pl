#Write a script to create an Indentity Matrix for the given size.
#For example, if the size is 4, then create Identity Matrix 4x4. 
#For more information about Indentity Matrix, please read the wiki page.

use strict;
use warnings;

my $size = 11;

my @aIdentityMatrix = ();

for my $a (0..$size-1){
	my @aRow = ();
	for my $b (0..$size-1){
		if ($a == $b){
			push (@aRow, 1);
		}	else {
			push (@aRow, 0);
		}
	}
	push ( @aIdentityMatrix , \@aRow);
}


foreach my $row (@aIdentityMatrix){
	foreach my $column ( @{$row} ) {
		print $column ."\t";
	}
	print "\n";
}