use v5.30;
my @int = (8,1,2,2,3);
my @ans;
foreach my $i (@int) {
    my $cnt = 0;
    for my $j (@int) {
	$cnt++ if ($j < $i);
    }
    push @ans, $cnt;
}
say "Input : \@int = (" .join(", ",@int).")";
say "Output: \@ans = (" .join(", ",@ans).")";
