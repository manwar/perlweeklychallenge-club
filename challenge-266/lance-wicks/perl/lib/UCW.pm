package UCW;

=pod

> A word is uncommon if it appears exactly once
> in one of the sentences and doesn’t appear in
> other sentence.

Example 1

Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')
=cut

sub words {
    my $self  = shift;
    my $line1 = shift;
    my $line2 = shift;

    my @line1_words = split( /\s+/, $line1 );
    my @line2_words = split( /\s+/, $line2 );

    my %words;
    for ( @line1_words, @line2_words ) {
        $words{$_}++;
    }

    my @words;
    for ( keys %words ) {
        if ( $words{$_} == 1 ) {
            push @words, $_;
        }
    }
    return [ sort @words ];
}

1;