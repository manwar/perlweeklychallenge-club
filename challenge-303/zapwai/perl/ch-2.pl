1use v5.38;
use List::Util qw(uniq);

sub del($val, @ints) {
    my $uval = $val + 1;
    my $lval = $val - 1;
    return grep { $_ != $uval && $_ != $lval } @ints;
}

sub T($m, $my_output, @l) {
    foreach my $node (uniq(@l)) {
	my $output = $my_output;
	$output .= "+" if ($output);
	$output .= "$node";
	my @new = @l;
	@new = del($node, @new);
	for my $i (0 .. $#new) {
	    if ($new[$i] == $node) {
		splice(@new, $i, 1);
		last;
	    }
	}
	if (@new) {
	    T($m, $output, @new);
	} else {
	    my $current_sum = eval($output);
	    $$m = $current_sum if ($$m < $current_sum);
	    $output = "";
	}
    }
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    print "Output: ";
    my $max = 0;
    T(\$max, "", @ints);
    say $max;
}

my @ints = (3, 4, 2);
proc(@ints);
@ints = (2,2,3,3,3,4);
proc(@ints);
