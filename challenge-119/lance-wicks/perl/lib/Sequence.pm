package Sequence;

use Moo;

sub no_one_on_one {
    my ( $self, $n ) = @_;

    my @seq;

    my $x = 0;
    while (1) {
        $x++;
        next unless $x =~ /^[123]/;
        next if $x =~ /[4567890]/g;
        next if $x =~ /11/g;
        push @seq, $x;
        last if @seq > $n - 1;
    }
    return $seq[-1];
}

1;

