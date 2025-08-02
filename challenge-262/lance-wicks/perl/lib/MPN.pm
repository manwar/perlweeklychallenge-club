package MPN;


sub max_pos_or_neg {
    my $self = shift;
    my @ints = @_;

    my $positives = $self->positives(@ints); 
    my $negatives = $self->negatives(@ints); 

    if ($positives > $negatives) { return $positives }
    if ($positives < $negatives) { return $negatives }
    return 0;

}

sub positives {
    my $self = shift;
    my @ints = @_;
    
    my $count = 0;
    for my $i (@ints) {
        $count++ if $i > 0;
    }

    return $count;
}

sub negatives {
    my $self = shift;
    my @ints = @_;
    
    my $count = 0;
    for my $i (@ints) {
        $count++ if $i < 0;
    }

    return $count;
}

1;