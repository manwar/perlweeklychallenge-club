package Ch2;
use strict;
use warnings;
use List::Util qw(min);

sub shortest_completing_word {
    my ( $target, @words ) = @_;
    my %target_count = get_letter_counts($target);

    my @valid_words;
    foreach my $word (@words) {
        my %word_count = get_letter_counts($word);
        push @valid_words, $word
          if is_completing( \%target_count, \%word_count );
    }

    return minstr(@valid_words);
}

sub get_letter_counts {
    my $s = shift;
    my %counts;
    $s =~ s/[^a-zA-Z]//gx;
    $s = lc $s;
    $counts{$_}++ for split //, $s;
    return %counts;
}

sub is_completing {
    my ( $target_count, $word_count ) = @_;
    foreach my $letter ( keys %$target_count ) {
        return 0
          if !$word_count->{$letter}
          || $word_count->{$letter} < $target_count->{$letter};
    }
    return 1;
}

sub minstr {
    my @strings = @_;
    return qw// unless @strings;
    return ( sort { length $a <=> length $b } @strings )[0];
}

# Test cases
use Test::More tests => 3;
is( shortest_completing_word( 'aBc 11c', 'accbbb', 'abc', 'abbc' ),
    'accbbb', 'Example 1' );
is( shortest_completing_word( 'Da2 abc', 'abcm', 'baacd', 'abaadc' ),
    'baacd', 'Example 2' );
is( shortest_completing_word( 'JB 007', 'jj', 'bb', 'bjb' ),
    'bjb', 'Example 3' );

done_testing();

1;