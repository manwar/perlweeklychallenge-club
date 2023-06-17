use strict;
use warnings;
use List::Util qw/all/;

sub good_strings {
    my ( $words_ref, $chars ) = @_;
    my %char_counts;
    $char_counts{$_}++ for split //, $chars;
    my $total = 0;
    foreach my $word (@$words_ref) {
        my %word_counts;
        $word_counts{$_}++ for split //, $word;
        if (
            all {
                exists $char_counts{$_} and $word_counts{$_} <= $char_counts{$_}
            } keys %word_counts
          )
        {
            $total += length $word;
        }
    }
    return $total;
}

my @words = ( "cat", "bt", "hat", "tree" );
my $chars = "atach";
print good_strings( \@words, $chars ), "\n";    # Output: 6

@words = ( "hello", "world", "challenge" );
$chars = "welldonehopper";
print good_strings( \@words, $chars ), "\n";    # Output: 10
