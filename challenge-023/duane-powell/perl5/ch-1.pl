#!/usr/bin/perl
use Modern::Perl;

# Create a script that prints nth order forward difference series. You should be a able to pass 
# the list of numbers and order number as command line parameters. Let me show you with an example.

# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to create 1st order 
# forward difference series (Y). So using the formula Y(i) = X(i+1) - X(i), we get the following 
# numbers: (9-5), (2-9), (8-2), (1-8), (6-1). In short, the final series would be: 4, -7, 6, -7, 5. 
# If you noticed, it has one less number than the original series. Similary you can carry on 2nd 
# order forward difference series like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.
#
my ($order, @series) = @ARGV; 
($order and @series > 1) || die "Usage:\n$0 order list-of-space-separated-ints\n";

# No point in order being larger than series size - 1
$order = scalar(@series)-1 if ($order >= @series);

say "order:\tseries:";
for (1 .. $order) {
	my @num;
	# we need two numbers to continue
	if (@series > 1) {
		my $x = shift @series;
		foreach my $n (@series) {
			push @num, $n-$x;
			$x = $n;
		}
		say "$_:\t" . join(",",@num);
	}
	@series = @num;
}

__END__

./ch-1.pl 5 5 9 2 8 1 6
order:  series:
1:      4,-7,6,-7,5
2:      -11,13,-13,12
3:      24,-26,25
4:      -50,51
5:      101

./ch-1.pl 10 1 2 3 4 5 6 7 8 9 10 10000 
order:  series:
1:      1,1,1,1,1,1,1,1,1,9990
2:      0,0,0,0,0,0,0,0,9989
3:      0,0,0,0,0,0,0,9989
4:      0,0,0,0,0,0,9989
5:      0,0,0,0,0,9989
6:      0,0,0,0,9989
7:      0,0,0,9989
8:      0,0,9989
9:      0,9989
10:     9989

