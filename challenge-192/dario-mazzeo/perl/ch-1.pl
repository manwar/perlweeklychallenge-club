# THE WEEKLY CHALLENGE - 192
# Task 1: Binary Flip
# Autore: Dario Mazzeo

print "5 -> ".BinaryFlip(5)."\n";
print "4 -> ".BinaryFlip(4)."\n";
print "6 -> ".BinaryFlip(6)."\n";

sub BinaryFlip{
	my $n=$_[0];
	my $nbit=length(sprintf("%b", $n));
	$n=$n^(2**$nbit-1);
	return $n;
}