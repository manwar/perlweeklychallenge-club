#
# # Challenge #1
#
# Write a script that takes 2 or more strings as command line parameters
# and print the longest common substring.

my $head = shift;
for my $n (reverse 1..(length $head)) {
    SUBSTRING: for my $i (0..((length $head)-$n)) {
	my $s = substr($head,$i,$n);
	next SUBSTRING unless @ARGV == grep(/$s/,@ARGV);
	print "$s\n";
	exit;
    }
}
