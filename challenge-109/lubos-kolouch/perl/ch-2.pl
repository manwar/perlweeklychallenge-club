use List::Util qw(sum);

my @numbers = (1,2,3,4,5,6,7);

for my $perm (permute(@numbers)) {
    my ($a, $b, $c, $d, $e, $f, $g) = @$perm;
    if (sum($a, $b) == sum($b, $c, $d) and sum($b, $c, $d) == sum($d, $e, $f) and sum($d, $e, $f) == sum($f, $g)) {
        print "a = $a\nb = $b\nc = $c\nd = $d\ne = $e\nf = $f\ng = $g\n";
        last;
    }
}

sub permute {
    my @items = @_;
    return [] unless @items;
    return map { [@items[$_], @$_] } 0..$#items for permute(@items[0..$_-1, $_+1..$#items]) for 0..$#items;
}

