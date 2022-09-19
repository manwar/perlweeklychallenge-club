# THE WEEKLY CHALLENGE - 182
# Task 2: Common Path
# Autore: Dario Mazzeo

my @in = ("/a/b/c/1/x.pl", "/a/b/c/d/e/2/x.pl", "/a/b/c/d/3/x.pl", "/a/b/c/4/x.pl", "/a/b/c/d/5/x.pl");

my $path="";
my $pathprec=$in[0];
foreach my $i (@in){
	$path=PercorsoInComune($i, $pathprec);
	$pathprec=$i;
}
print "$path\n";


sub PercorsoInComune{
	my @p1=split("\/", $_[0]); pop(@p1);
	my @p2=split ("\/", $_[1]); pop(@p2);
	
	my $path="";
	foreach my $i (@p1){
		foreach my $j (@p2){
			if ($i eq $j){$path.="$i\/";}
		}
	}
	return $path;
}