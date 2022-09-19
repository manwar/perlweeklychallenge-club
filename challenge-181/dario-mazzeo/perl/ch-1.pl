 # THE WEEKLY CHALLENGE - 181
 # Task 1: Sentence Order
 # Autore: Dario Mazzeo

 my $testo="All he could think about was how it would all end. There was
 still a bit of uncertainty in the equation, but the basics
 were there for anyone to see. No matter how much he tried to
 see the positive, it wasn't anywhere to be seen. The end was
 coming and it wasn't going to be pretty.";
$testo=~s/[^\w\.\,\']/ /g;
$testo=~s/  */ /g;
my @frasi=split(/\./, $testo);

foreach my $f (@frasi){
	my @parole=split(" ", $f);
	my $ord="";
	foreach my $p (sort {lc($a) cmp lc($b)} @parole){$ord.="$p ";}
	$ord=~s/(.*) $/$1/;
	print "$ord. ";
}
print "\n";	