use v5.30.0;
use Algorithm::Permute;
my @ints = (1, 17, 8);
#my @ints = (2,2,2);
say "Input: \@ints = (" . join(",",@ints) . ")";
my $p = Algorithm::Permute->new(\@ints);
print "Output: ";
my $out;
while (my @perm = $p->next) {
    my $current_print = "(" . join(",",@perm) . ")";
    next if ($out =~ m/$current_print/);
    $out .= $current_print if is_squareful(@perm);
}
$out =~ s/\)\(/\), \(/;
say $out;

sub is_squareful {
    my @list = @_;
    my $cnt;
    foreach (0 .. $#list-1) {
	my $sum = $list[$_] + $list[$_+1];
	$cnt++ if (is_square($sum));
    }
    return 1 if ($cnt == $#list);
    0
}

sub is_square {
    my $num = shift;
    my $U = int (sqrt($num));
    return 1 if ($U**2 == $num);
    0
}
