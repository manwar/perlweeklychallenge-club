# THE WEEKLY CHALLENGE - 186
# Task 1: Zip List
# Autore: Dario Mazzeo

my @a = (1, 2, 3);
my @b = ('a', 'b', 'c');

print zip(\@a, \@b);
print "\n";
print zip(\@b, \@a);
print "\n";


sub zip{
	my @a=@{$_[0]};
	my @b=@{$_[1]};
	my @out=();
	for (my $i=0; $i<$#a; $i++){
		push (@out, $a[$i]);
		push (@out, $b[$i]);
	}
	return @out;
}