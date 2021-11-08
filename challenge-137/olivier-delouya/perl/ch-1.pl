use strict; 
use POSIX qw(strftime); 
my @time_base=(0, 0, 1, 31, 11); 
for(my $i=0, my $j=0; $i<201; $i++) 
	{ 
	($j++, print($i+1900, ($j%5)? ', ': "\n")) if(strftime('%V', @time_base, $i) == 53); 
	}
