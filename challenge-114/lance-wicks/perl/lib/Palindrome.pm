package Palindrome;

sub num {
    my ( $self, $N ) = @_;

    my $counter = $N + 1;
    while ( $counter ne reverse $counter ) {
        $counter++;
    }
    return $counter;
}

1;
