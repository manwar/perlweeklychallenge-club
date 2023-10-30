use v5.30;
my @ints = (0, 2, 9, 4, 6);
say "Input: \@ints = (" .join(", ",@ints).")";
print "Output: ";
my $a = 0;
for my $i (0 .. $#ints) {
    my @new = (@ints[0 .. $i-1], @ints[$i + 1 .. $#ints]);
    if ($i == 0) {
	@new = @ints[1 .. $#ints];
    } elsif ($i == $#ints) {
	@new = @ints[0 .. $#ints - 1];
    }
    $a = 1    if (is_incr(@new));
}
$a ? say "True" : say "False";
sub is_incr {
    my @list = @_;
    my $c = 0;
    for my $i (0 .. $#list - 1) {
	$c++ if ( $list[$i] < $list[$i+1] );
    }
    return 1 if ($c == $#list);
    0
}
