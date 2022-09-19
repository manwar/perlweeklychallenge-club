# THE WEEKLY CHALLENGE - 180
# Task 2: Trim List
# Autore: Dario Mazzeo

my @n=(9,0,6,2,3,8,5);
my $i=4;

my @out=();
foreach my $j (@n){
	if ($j>$i){
		push(@out, $j);
	}
}

my $output="(@out)";
$output=~s/ /,/g;
print "$output\n";