package Bits;

use Moo;

sub swap {
    my ($self,$n) = @_;

    my $binary = sprintf("%08b",$n);
    my $reversed_binary;
    my @bits = $binary =~ /(\d{2})/g;
    for (@bits ) {
        my $rev = reverse $_;
        $reversed_binary .= $rev
    }


    return oct "0b$reversed_binary";
}

1;
