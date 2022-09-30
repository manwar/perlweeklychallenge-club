# THE WEEKLY CHALLENGE - 184
# Task 2: Split Array
# Autore: Dario Mazzeo

my @list = ( 'a 1 2 b 0', '3 c 4 d');

my @lw=();
my @ln=();
foreach my $i (@list){
	my @t=split(/ /, $i);
	my $tmpn="";
	my $tmpw="";
	foreach my $j (@t){
		if ($j=~/\d/){$tmpn.="$j,";}
		else{$tmpw.="$j,";}
	}
	$tmpw=~s/,$//; $tmpn=~s/,$//;
	push (@lw, $tmpw);
	push (@ln, $tmpn);
}

foreach my $i (@ln){print "[$i] ";}
print "and ";
foreach my $i (@lw){print "[$i] ";}
print "\n";