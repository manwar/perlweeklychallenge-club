package Caesar;

use Moo;

sub encode {
    my ( $self, %args ) = @_;

    my $cipher = $self->_cipher( 'n' => $args{n}, mode => 'encode' );

    my $text;
    my @chars = split "", $args{string};
    for my $char (@chars) {
        $text .= $cipher->{ lc($char) };

    }

    return uc $text;

}

sub decode {
    my ( $self, %args ) = @_;

    my $cipher = $self->_cipher( 'n' => $args{n}, mode => 'decode' );

    my $text;
    my @chars = split "", $args{string};
    for my $char (@chars) {
        $text .= $cipher->{ lc($char) };

    }

    return uc $text;
}

1;

sub _cipher {
    my ( $self, %args ) = @_;

    my @alpha  = (qw/a b c d e f g h i j k l m n o p q r s t u v w x y z/);
    my @cipher = @alpha;

    if ( $args{mode} eq 'decode' ) {

        for ( 1 .. $args{n} ) {
            my $char = pop @cipher;
            unshift @cipher, $char;
        }
    }
    else {
        for ( 1 .. $args{n} ) {
            my $char = shift @cipher;
            push @cipher, $char;
        }

    }

    my %code;
    for my $i ( 0 .. 25 ) {
        $code{ $cipher[$i] } = $alpha[$i];
    }

    $code{' '} = ' ';

    return \%code;
}

