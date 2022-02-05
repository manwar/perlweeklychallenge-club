use strict;
use warnings;

sub get_fib_word {
    my ($word1, $word2) = @_;

    while (length($word2) < 51) {
        my $new_word = $word1.$word2;
        $word1 = $word2;
        $word2 = $new_word;
    }

    return substr($word2,50,1);
}

use Test::More;

is(get_fib_word('1234', '5678'), 7);
done_testing;
