package Invert;

use Moo;

sub bit {
    my ($self, %args) = @_;

    my $m = $args{m};
    my $n = $args{n};

    my $bin_m = sprintf("%08b",$m);

    my $bit = substr $bin_m, -($n), 1;

    substr $bin_m, -($n), 1, $bit ? 0 : 1 ;

    return oct "0b$bin_m";
}


1;
