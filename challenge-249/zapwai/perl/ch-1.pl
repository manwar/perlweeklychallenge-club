use v5.30;
my @ints = (3, 2, 3, 2, 2, 2);
#my @ints = (1, 2, 3, 4);
say "Input: @ints";
print "Output: ";
my %h;
$h{$_}++ for (@ints);
my $cnt = 0;
for my $k ( values %h ) {
    if ($k % 2 != 0) {
	say "()";
	last;
    } else {
	$cnt++;
    }
}
if ($cnt == scalar keys %h) {
    foreach my $k ( keys %h ) {
	my $d = $h{$k} / 2;
	print "($k, $k) " x $d;
    }
    print "\n";
}
