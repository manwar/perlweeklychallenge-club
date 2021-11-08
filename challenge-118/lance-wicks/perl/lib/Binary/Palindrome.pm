package Binary::Palindrome;

use Moo;

sub is_palindrome {
    my ( $self, $n ) = @_;

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
