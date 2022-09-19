# THE WEEKLY CHALLENGE - 170
# Task 2: Kronecker Product
# Autore: Dario Mazzeo

# Separare le righe della matrica con il carattere ";"
my $inputA="1,2;3,4";
my $inputB="5,6;7,8";

# Esempio n. 2
# $inputA="1,-4,7;-2,3,3";
# $inputB="8,-9,-6,5;1,-3,-4,7;2,8,-8,-3;1,2,-5,-1";

my %AB=();
my @righeA=split(";", $inputA); my @colonneA=();
my @righeB=(); my @colonneB=();
my $rr=0; my $cc=0;

foreach my $rigaA (@righeA){
	@colonneA=split(",", $rigaA);
	foreach my $colonnaA (@colonneA){
		my $vettore=Moltiplica($colonnaA, $inputB);
		@righeB=split(";",$vettore);
		foreach my $rigaB (@righeB){
			@colonneB=split(",",$rigaB);
			foreach my $colonnaB (@colonneB){
				$AB{"$rr-$cc"}=$colonnaB;
				$cc++;
			}
			$rr++; $cc-=$#colonneB+1;
		}
		$rr-=$#righeB+1; $cc+=$#colonneB+1;
	}
	$rr+=$#righeB+1; $cc=0;
}

foreach my $r (0 .. ($#righeA+1)*($#righeB+1)){
	foreach my $c (0 .. ($#colonneA+1)*($#colonneB+1)){
		print $AB{"$r-$c"}." ";
	}
	print "\n";
}

exit;



sub Moltiplica{
my $mul=$_[0];
my $arr=$_[1];
my $tmp="";
my $ss=1;

my @valori=split(/[,;]/, $arr);
my @separatori=split(/-?\d*/, $arr);
foreach my $v (@valori){
	$tmp.=($mul*$v).@separatori[$ss];
	$ss++;
}

return $tmp;
}