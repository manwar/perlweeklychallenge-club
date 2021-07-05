package Nibble;

use Moo;

sub swap {
    my ( $self, $n ) = @_;

    my $oct = sprintf( "%08b", $n );

    $oct =~ /^(.{4})(.{4})$/;

    return oct "0b$2$1";
}

1;

