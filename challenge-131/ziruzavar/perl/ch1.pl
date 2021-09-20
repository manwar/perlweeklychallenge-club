use strict;
use warnings;
use Data::Dumper;

sub group_ints{
	my (@array) = @_;
	my @output = ([$array[0]]);	
	my $counter = 0;
	for (my $i=0; $i<@array-1; $i++){
		if ($array[$i]+1 == $array[$i+1]){
			push(@{$output[$counter]}, $array[$i+1]);
		}else{
			$counter++;
			push(@output, [$array[$i+1]]);
		}
	}
	return \@output;


}


my @input = (1,2,3,6,7,8,9);
my @input2 = (11, 12, 14, 17, 18, 19);
my @input3 = (2, 4, 6, 8);
my @input4 = (1, 2, 3, 4, 5);

print Dumper(group_ints(@input));
print Dumper(group_ints(@input2));
print Dumper(group_ints(@input3));
print Dumper(group_ints(@input4));
