use v6;

my @mat = (<7 8 9>, <1 2 3>,  <4 5 6>, );
# say @mat;
my @best-path;
my $min = Inf;
my @empty-path;

traverse-mat(0, 0, 0, @empty-path);

sub traverse-mat (UInt $i, UInt $j, UInt $sum, @path is copy) {
    my $new-sum = $sum + @mat[$i][$j];
    return if $new-sum > $min;
    push @path, @mat[$i][$j];
    if @mat[$i][$j+1].defined {
        traverse-mat($i, $j+1, $new-sum, @path);
    }
    if @mat[$i+1][$j].defined {
        traverse-mat($i+1, $j, $new-sum, @path);
    }
    unless (@mat[$i][$j+1].defined or @mat[$i+1][$j].defined) {
        @best-path = @path;
        $min = $new-sum;
    }
}
say $min, " (", join(' → ', @best-path), ")";
