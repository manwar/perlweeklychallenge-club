# THE WEEKLY CHALLENGE - 171
# Task 1: Abundant Number
# Autore: Dario Mazzeo

my $abu=1;
my $num=0;
do {
	my $tot=0;
	foreach my $div (1 .. 100){
		if ($div<$abu && SeDivisore($abu,$div)==1){$tot+=$div;}
	}
	if ($tot>$abu){$num++; print "$abu\n";}
	$abu++;
} while ($num<20);
exit;

sub SeDivisore{
my $a=$_[0];
my $b=$_[1];

if (($a % $b)==0){return 1;}
else {return 0;}
}