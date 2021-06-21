package Binary::Palindrome;

sub is_palindrome {
    my ( $self, $n ) = @_;
    # 1. get a binary representation of the integer
    # 2. reverse it
    # 3. is that the same ar step 1?

    my $bin = $self->represent_as_binary($n);
    my $rev = reverse $bin;

    if   ( $rev eq $bin ) { return 1 }
    else                  { return 0 }
}

sub represent_as_binary {
    my ( $self, $n ) = @_;
    return sprintf( "%b", $n );
}

1;
