use v5.30.0;
#my @citations = (10,8,5,4,3);
my @citations = (25,8,5,3,3);

my $h = 0;
for (1 .. $#citations + 1) {
    $h++;
    my $cnt;
    for (@citations) {
	$cnt++ if ($_ > $h);
    }
    next if ($cnt > $h);
    last;
}

say "Input: \@citations = (".join(", ",@citations).")";
say "Output: $h";

