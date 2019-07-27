#
# # Challenge #1
#
# Write a script that takes 2 or more strings as command line parameters
# and print the longest common substring.

sub of_size {
    my ($n,$s) = @_;
    my @subs = ();
    for (my $i = 0; ($i+$n) <= length $s; $i++) {
	push @subs, substr($s,$i,$n);
    }
    return @subs; #substrings of $s of length $n.
}

my $head = shift;
for my $n (reverse 1..(length $head)) {
    for my $s (of_size($n,$head)) {
	if (@ARGV == grep(/$s/,@ARGV)) {
	    print "$s\n";
	    exit;
	}
    }
}
