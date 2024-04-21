use strict;
use warnings;
use feature 'say';

sub complete_word {
    my ($in_str, @in_words) = @_;
    my %letters;
    $letters{$_}++ for grep { $_ =~ /[a-z]/ } map { lc } split //, $in_str;
    my @result;
    WORD: for my $word (@in_words) {
        my %word_let;
        $word_let{$_}++ for map { lc } split //, $word;
        for my $k (keys %letters) {
            next WORD unless exists $word_let{$k};
            next WORD if $letters{$k} > $word_let{$k};
        }
        push @result, $word;
    }
    return (sort {length $a <=> length $b} @result)[0];
}

my @tests = ( ['aBc 11c', ['accbbb', 'abc', 'abbc']],
              ['Da2 abc', ['abcm', 'baacd', 'abaadc']],
              ['JB 007', ['jj', 'bb', 'bjb']]  );
for my $test (@tests) {
    printf "%-8s - %-10s => ", $test->[0], "$test->[1][0] ...";
    say complete_word $test->[0], @{$test->[1]};
}
