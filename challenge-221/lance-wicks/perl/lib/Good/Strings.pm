package Good::Strings;
use feature 'signatures';
use Moo;

sub sum_lengths ( $self, $words, $chars ) {
    my @chars_array = sort split '', $chars;
    my %chars_hash  = map { $_ => $_ } @chars_array;

    my $char_count = 0;

    for my $word (@$words) {
        my $built_word = $self->_build_word(
            word  => $word,
            chars => \%chars_hash,
        );

        next unless $built_word;
        $char_count += length $word if $word eq $built_word;
    }

    return $char_count;
}

sub _build_word {
    my ( $self, %params ) = @_;

    my @word_array = split '', $params{word};

    my $built_word;
    for my $char (@word_array) {
        $built_word .= $params{chars}{$char} if $params{chars}{$char};
    }

    return $built_word;
}

1;
