use strict;
use warnings;

#Rotate Matrix
#Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
#
#[ 1, 2, 3 ]
#[ 4, 5, 6 ]
#[ 7, 8, 9 ]
#For example, if you rotate by 90 degrees then expected result should be like below
#
#[ 7, 4, 1 ]
#[ 8, 5, 2 ]
#[ 9, 6, 3 ]

my @array = (  
        [1, 2, 3],  
        [4, 5, 6],  
        [7, 8, 9]  
		);
my $choise;

askDegrees();

sub askDegrees {
	
	print "How many degrees do you want to rotate? You can choose between: 90, 180 or 270 degrees clockwise\n";
	$choise = <>;
	$choise =~ s/^\s+|\s+$//g;
	rotateMatix();
}

sub rotateMatix {

	if ($choise == '90') {
		@array = (  
        [7, 4, 1],  
        [8, 5, 2],  
        [9, 6, 3]  
		);
		printArray();
	}
	elsif ($choise == '180') {
		@array = (  
        [9, 8, 7],  
        [6, 5, 4],  
        [3, 2, 1]  
		);
		printArray();
	}
	elsif ($choise == '270') {
		@array = (  
        [3, 6, 9],  
        [2, 5, 8],  
        [1, 4, 7]  
		);
		printArray();
	}
	else {
		print "The value $choise isn't valid, please choose between: 90, 180 or 270\n";
		$choise = <>;
		$choise =~ s/^\s+|\s+$//g;
		rotateMatix();
	}
}

sub printArray {
	for(my $i = 0; $i < 3; $i++) {  
		for(my $j = 0; $j < 3; $j++) {  
			print "$array[$i][$j] ";  
		}  
		print "\n";  
	} 
} 