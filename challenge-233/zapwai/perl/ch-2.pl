use v5.30;
my @ints = (1,1,2,2,2,3);
@ints = (2,3,1,3,2);
#@ints = (-1,1,-6,4,5,-6,1,4,1);
say "Input: \@ints = @ints";
my %h;
$h{$_}++ foreach (@ints);
my @key = keys %h;
my @freq;
push @freq, $h{$_} foreach (@key);
my $c = 0;
do {
    $c = 0;
    for my $i (0 .. $#freq - 1) {
	if ($freq[$i] < $freq[$i + 1]) {
	    swap(\@freq, $i);
	    swap(\@key, $i);
	    $c++;
	}
	if ($freq[$i] == $freq[$i + 1]) {
	    if ( $key[$i] > $key[$i+1]) {
		swap(\@key, $i);
		$c++;
	    }
	}
    }
} while ($c != 0);
for (0 .. $#freq) {
    my $c = 0;
    do {
	if ($freq[$_] == $freq[$_ + 1]) {
	    if ($key[$_] < $key[$_]) {
		$c++;
		swap(\@key, $_);
	    }
	}
    } while ($c != 0);
}
print "Output: ";
for (reverse 0 .. $#freq) {
    print "$key[$_] " x $freq[$_];
}
print "\n";
sub swap {
    my ($ref, $i) = @_;
    my $temp = $$ref[$i];
    $$ref[$i] = $$ref[$i+1];
    $$ref[$i+1] = $temp;
}
