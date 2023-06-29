use v6;
my $n = 20;
say "Input: \$n = $n";
print "Output: ";
my @list;
list($n);
say @list.elems();
say "\t[@list[]]";
sub list(int $n) {
    for (2 .. $n) {
	@list.push($_) if $_.is-prime();
    }
}
