use v5.38;
my $str = 'PeRlwEKLy';
say "Input: \$str = $str";
say "Output: " . proc($str);

sub proc ($str) {
    my @letters = split "", $str;
    my @upper, my @lower;
    for my $l (@letters) {
	push @upper, $l if ($l =~ /[A-Z]/);
	push @lower, $l if ($l =~ /[a-z]/);
    }
    my @common;
    foreach my $u (@upper) {
	foreach my $l (@lower) {
	    push @common, $u if (lc $u eq $l);
	}
    }
    @common = sort @common;
    return $common[$#common];
}
