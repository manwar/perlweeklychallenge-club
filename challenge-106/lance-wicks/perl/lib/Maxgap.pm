package Maxgap;

sub maxgap {
    my ($self, @integers) = @_;

    @integers = sort @integers;

    my $maxgap = 0;
    for my $i (1 .. @integers-1){
        my $gap = $integers[$i] - $integers[$i-1];
        if ( $gap > $maxgap) {
            $maxgap = $gap;
        }
    }

    return $maxgap;
}


1;
