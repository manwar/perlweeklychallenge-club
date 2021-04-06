package Descriptive;

use Moo;

sub list {
    my $self = shift;
    my @list;

    for my $num (1..30_000) {
        push @list, $num if $self->is_self_desc($num);
    }

    return \@list;
}

sub is_self_desc {
    my ($self,$num) = @_;

    my $description;
    for my $int (0..9) {
        $description .= () = $num =~ /$int/g;
    }
    my $length_of_num = length $num;

    $description = substr $description, 0, $length_of_num;

    return 1 if $description == $num;
    return 0;
}

1;
