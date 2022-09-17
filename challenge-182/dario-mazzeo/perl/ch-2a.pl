# THE WEEKLY CHALLENGE - 182
# Task 2: Common Path
# Autore: Dario Mazzeo

my @in = ("/a/b/c/1/x.pl", "/a/b/c/d/e/2/x.pl", "/a/b/c/d/3/x.pl", "/a/b/c/4/x.pl", "/a/b/c/d/5/x.pl");

my $path="";
my @pathprec=split("\/", $in[0]); pop(@pathprec);
foreach my $i (@in){
	my @p1=split("\/", $i); pop(@p1);
	$path=PercorsoInComune(\@p1, \@pathprec);
	@pathprec=@p1;
}
print "$path\n";


sub PercorsoInComune{
	my @p1=@{$_[0]};
	my @p2=@{$_[1]};
	my $path="";
	foreach my $i (@p1){
		foreach my $j (@p2){
			if ($i eq $j){$path.="$i\/";}
		}
	}
	return $path;
}