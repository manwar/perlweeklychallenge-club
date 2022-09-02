# THE WEEKLY CHALLENGE - 180
# Task 1: First Unique Character
# Autore: Dario Mazzeo

my $s="Perl Weekly Challenge";
my $s="Long Live Perl";
my %freq=();

for (my $i=0; $i<length($s); $i++){
	$freq{substr($s,$i,1)}++;
}

for (my $i=0; $i<length($s); $i++){
	my $c=substr($s,$i,1);
	if ($freq{$c}==1){
		print "$i '$c' e' il primo carattere univoco\n";
		last;
	}
}