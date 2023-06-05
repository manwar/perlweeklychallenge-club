package My::Sorted::Square;
use Moo;

sub run {
    my ( $self, @list ) = @_;

    my @squared_list;
    for my $num (@list) {
        push @squared_list, $num**2;
    }

    @squared_list = sort { $a <=> $b } @squared_list;
    return @squared_list;
}

1;
