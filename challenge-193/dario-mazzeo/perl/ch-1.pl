# THE WEEKLY CHALLENGE - 193
# Task 1: Binary String
# Autore: Dario Mazzeo

print Espandi(2);
print Espandi(3);

sub Espandi{
	my $out="";
	foreach my $b (0 .. 2**$_[0]-1){
		$out.=sprintf("%0$_[0]b, ", $b);
	}
	$out=~s/, $/\n/;
	return $out;
}