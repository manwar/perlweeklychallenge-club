=pod

=head1 Question 2

Higher Integer Set Bits
You are given a positive integer $N.
Write a script to find the next higher integer having the same number of 1 bits in binary representation as $N

=head1 Approach

Also starting with a simple approach. Count 1s in bitstring of $N and increase $N until
we have another bitstring with the same number of 1s

Should check on this approach again later to exploit the properties of binary representation to determine
an easier way than iterating through

=cut

sub count_ones {
	my $n = shift;
	# sprintf "%b, $n" creates a bitstring for $n and
	# tr/1// counts the number of 1s in the string
	return sprintf("%b", $n) =~ tr/1//;
}

die "Need to enter a positive integer!\n" if @ARGV == 0;

my $n = shift;
die "Integer needs to be positive!\n" if $n < 1;

my $count = count_ones $n; 
# Iterate until we have a match
do { ++$n; } until count_ones ($n) == $count;
print "$n\n";

