use v5.30;
my @bills = (5, 5, 5, 10, 20);
#@bills = (5,5,10,10,20);
say "Input: \@bills = (" . join(", ", @bills) . ")";
print "Output: ";
my %count;
my $flag = 1;
for my $i (0 .. $#bills) {
    if ($bills[$i] == 10) {
	if ($count{5} > 0) {
	    $count{5}--;
	} else {
	    $flag = 0;
	}
    } elsif ($bills[$i] == 20) {
	if (($count{5} > 0) && ($count{10} > 0)) {
	    $count{5}--;
	    $count{10}--;	    
	} else {
	    $flag = 0;
	}
    }
    $count{$bills[$i]}++;
}
$flag ? { say "True" } : { say "False" };
