use strict;
use warnings;

sub find_odd{
	my $n = shift;
	my @arr = @$n;
	my %h;

	foreach my $i (@arr){
		if (exists($h{$i})){
			$h{$i}++ ;
		}else{
			$h{$i} = 1;
		}
	}
	foreach my $key (keys %h){
		if ($h{$key} % 2 != 0){
			return $key;
		}
	}	
}

my @N = (2, 5, 4, 4, 5, 5, 2);
print find_odd(\@N);
