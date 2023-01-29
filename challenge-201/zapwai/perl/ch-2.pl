use v5.30.0;
no warnings "experimental";
my $n = $ARGV[0] || 5;
say "Input: \$n = $n";
print "Output: " ;
my @set = (join(" ",(1) x $n));
my $i=-1;
do {
    $i++;
    rout($set[$i]);
    @set = grep { defined($_) } @set;
} until (length $set[$i] <= 3);
my $length = @set;
do {
    rout($set[$i]);
    $i++;
} while ($i < $length);
push @set, $n;
say scalar @set;
say foreach @set;
sub rout {
    my $s = shift;
    my @a = split(" ", $s);
    return "no" if (@a <= 2);
    if ($a[$#a] != 1) {
	for (1 .. @a - 2) {
	    my $str = chonk($_, @a);
	    push @set, $str unless ($str ~~ @set);
	}
    }
    my $str = chonk(0, @a);
    push @set, $str unless ($str ~~ @set);
}
sub chonk {			#add two elems, given offset.
    my ($offset, @a) = @_;
    my $num = $a[$#a - $offset] + $a[$#a - $offset - 1];
    splice @a, $#a - $offset - 1, 2, $num;
    my $bad_cnt;
    for (1.. $#a) {
	$bad_cnt++ if ($a[$_ - 1] > $a[$_]);
    }
    return if ($bad_cnt);
    return join(" ",@a);
}
