package OddOneOut;
use Moo;

sub count {
    my ( $self, @words ) = @_;
    my $count = 0;

    map { $count += $self->is_word_not_alpha_order($_) } @words;

    return $count;
}

sub is_word_not_alpha_order {
    my ( $self, $word ) = @_;

    my @letters = split '', $word;
    @letters = sort @letters;
    my $sorted_word = join '', @letters;

    return 0 + !!( $word ne $sorted_word );
}

1.
