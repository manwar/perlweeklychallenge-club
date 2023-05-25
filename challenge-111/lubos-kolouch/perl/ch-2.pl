use strict;
use warnings;

sub find_longest_ordered_words {
    my ($filename) = @_;

    open my $fh, '<', $filename or die "Could not open $filename: $!";
    my @words = <$fh>;
    chomp @words;
    close $fh;

    my $longest_length = 0;
    my @longest_words;
    for my $word (@words) {
        if (lc($word) eq join('', sort split //, lc($word))) {
            if (length($word) > $longest_length) {
                $longest_length = length($word);
                @longest_words = ($word);
            } elsif (length($word) == $longest_length) {
                push @longest_words, $word;
            }
        }
    }
    return @longest_words;
}

my @longest_ordered_words = find_longest_ordered_words('words.txt');
print join("\n", @longest_ordered_words), "\n";

