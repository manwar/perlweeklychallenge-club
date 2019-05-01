use strict;
use warnings;
use feature 'say';
sub is_anagram {
    my ($word1, $word2) = @_;
    return 0 if length $word1 != length $word2;
    my $letters1 = join "", sort split "", $word1;
    my $letters2 = join "", sort split "", $word2;
    return $letters1 eq $letters2
}
for ( [qw / ban bane/], [qw /post post/], [qw / post spot /], [qw /post spot/], [qw / pots spot/], [qw /pots taps/] ) {
    say "$$_[0] $$_[1]:\t", is_anagram($$_[0], $$_[1]) ? "True" : "False";
}
