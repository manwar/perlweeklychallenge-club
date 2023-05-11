use v5.30.0;
my @words = ('abc', 'abcd', 'bcd');
my $reg = "AB1 2CD";
my @letters = split("",lc $reg);
my @L;
for (@letters) {
    push @L, $_ if ($_ =~ m/[a-z]/);
}
my $len = $#L + 1;
my $cnt;
my @matches;
foreach my $word (@words) {
    $cnt = 0;
    foreach my $letter (@L) {
	$cnt++ if ($word =~ $letter);
	push @matches, $word if ($cnt == $len);	
    }
}
say "Input: \@words = (" . join(",",@words) . "), \$reg = '$reg'";
print "Output: ";
say "(" . join(",",@matches) . ")";
