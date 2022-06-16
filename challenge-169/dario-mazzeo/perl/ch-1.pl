# Autore: Dario Mazzeo (dmazzeo@ingele.com)
# THE WEEKLY CHALLENGE - 169
# Task 1: Brilliant Numbers

my @primi=(2,3,5,7,11,13,17,19,23);
my %ris=();
my $out="";

foreach my $i (@primi){
	foreach my $j (@primi){
		if ($ris{$i*$j}==0 && length($i) eq length($j)){
			$ris{$i*$j}=1;
		}
	}
}

my $c=0;
foreach my $i (sort {$a <=> $b} keys %ris){
	if ($c<20){$out.="$i, ";}
	$c++;
}

$out=~s/, $//;
print "$out\n";