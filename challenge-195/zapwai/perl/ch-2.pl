#!/usr/bin/env perl
my @list = (1,1,4,2,6);
my @freq;
my $ans;
foreach my $num (@list) {
    next if ($num % 2 == 1);
    $freq[$num]++;
}
if (!@freq) {
    $ans = -1;
}
my $max_freq;
for (1 .. $#freq/2) {
    my $i = 2*$_;
    if ($max_freq < $freq[$i]) {
	$max_freq = $freq[$i]
    }
}
for my $num (1 .. $#freq/2) {
    my $i = 2*$num;
    if ( $freq[$i] == $max_freq ) {
	$ans = $i;
	last;
    }
}
print "Input: \@list = @list\n";
print "Output: $ans\n";
