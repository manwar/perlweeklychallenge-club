use strict;
use warnings;

sub count_unsorted_words {
    my @words = @_;
    my $count = 0;

    for my $word (@words) {
        $count++ if is_unsorted($word);
    }

    return $count;
}

sub is_unsorted {
    my $word          = shift;
    my $previous_char = substr( $word, 0, 1 );

    for my $i ( 1 .. length($word) - 1 ) {
        my $current_char = substr( $word, $i, 1 );
        return 1 if $current_char lt $previous_char;
        $previous_char = $current_char;
    }

    return 0;
}

# Test cases
my @words1 = ( 'abc', 'xyz', 'tsu' );
my @words2 = ( 'rat', 'cab', 'dad' );
my @words3 = ( 'x',   'y',   'z' );

print count_unsorted_words(@words1), "\n";    # Output: 1
print count_unsorted_words(@words2), "\n";    # Output: 3
print count_unsorted_words(@words3), "\n";    # Output: 0
