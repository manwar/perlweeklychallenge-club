use v5.30;
my @int1 = (2,1,3,2);
my @int2 = (1,1,1,1);
my @int3 = (1,2,3,4);
for my $r (\@int1, \@int2, \@int3) {
    my @int = @$r;
    say "Input: \@int  = (" . join(",",@int) . ")";
    print "Output: ";
    my %h;
    $h{$_}++ for (@int);
    my $sum = 0;
    for (keys %h) {
	$sum = $sum + $_ if ($h{$_} == 1);
    }
    say $sum;
}
