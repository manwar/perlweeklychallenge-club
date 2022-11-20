# THE WEEKLY CHALLENGE - 190
# Task 1: Capital Detection
# Autore: Dario Mazzeo

printf("Perl %d\n", Verifica("Perl"));
printf("TPF %d\n", Verifica("TPF"));
printf("PyThon %d\n", Verifica("PyThon"));
printf("raku %d\n", Verifica("raku"));
exit;

sub Verifica{
my $in=$_[0];
my $nfc=0;
my $nc=0;
my $nm=0;
for (my $i=0; $i<length($in); $i++){
	my $c=substr($in, $i, 1);
	my $cc=uc($c);
	my $cm=lc($c);
	if ($i==0 && $c eq $cc){$nfc++;}
	if ($c eq $cc){$nc++;}
	else{$nm++;}
}

if ($nfc==1 && $nc==1){return 1;} # Only first letter is capital and all others are small.
elsif ($nc==0){return 1;} # Every letter is small.
elsif ($nm==0){return 1;} # Every letter is capital.
else{return 0;}
print "fc: $nfc, c: $nc, m: $nm\n";
}