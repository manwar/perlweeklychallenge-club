package Chowla;

use Moo;

sub list {
    my ($self,$max) = @_;
    my @chowla_numbers;
    for my $n (1..$max) {
        push @chowla_numbers, $self->n($n);
    }
    return \@chowla_numbers;
}

sub n {
    my ($self,$num) = @_;

    my $total = 0;
    for my $n (2..$num-1) {
        if ($num % $n == 0) {
            $total += $n;
        }
    }
    return $total;
}

1;
