use v5.30;
my @ints = (3, 2, 1, 4);
my ($min, $max) = (1000000, -1000000);
for my $i (0 .. $#ints) {
    $min = $ints[$i] if ( $ints[$i] < $min);
    $max = $ints[$i] if ( $ints[$i] > $max);    
}
my @list = grep {($_ != $min) && ($_ != $max)} @ints;
say "Input: \@ints = (" . join(",",@ints) . ")";
print "Output: ";
if (!@list) {
    say "-1"
} else {
    say "(" . join(",",@list) . ")";
}
