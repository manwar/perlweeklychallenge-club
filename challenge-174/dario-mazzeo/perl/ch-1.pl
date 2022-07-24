# THE WEEKLY CHALLENGE - 174
# Task 1: Disarium Numbers
# Autore: Dario Mazzeo

my $count=1;
my $i=0;

do{
	if (is_disarium($count)){print "$count\n"; $i++;}
	$count++;
} while($i<19);
exit;


sub is_disarium{
	my $num=$_[0];
	
	my $val=0;
	for (my $i=0; $i<length($num); $i++){
			$val+=int(substr($num, $i, 1)) ** ($i+1);
	}

	if ($val==$num){return 1;}
	else {return 0;}
}