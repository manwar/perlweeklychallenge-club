use v5.30.0;
my @nums = (1, 2, 2, 4);
#my @nums = (1,2,3,3);
#my @nums = (1,2,3,4);
say "Input: \@nums = (".join(",",@nums).")";
print "Output: ";
my $catch;			# flag for printing -1
for (1 .. $#nums) {
    my $i = $nums[$_ - 1];
    my $j = $nums[$_];
    if ($j - $i == 2) {
	say "(".($i+1).",".($i+2).")";
	$catch = 1;
	last;
    } elsif ($j - $i == 0) {
	say "($i,".($i+1).")";
	$catch = 1;
	last;
    }
}
say "-1" unless ($catch);
