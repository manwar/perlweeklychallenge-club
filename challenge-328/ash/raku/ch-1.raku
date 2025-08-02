# Task 1 of The Weekly Challenge 328
# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/#TASK1

say replace('a?z');    # abz
say replace('pe?k');   # peak
say replace('gra?te'); # grabte

# The task says to "replace all '?', so:"
say replace('a?z?'); # abzc

sub replace($str is copy) {
    my @options = ['a'..'z'] (-) $str.comb;
    my $option = @options.sort.first.key;

    $str ~~ s/'?'/$option/;

    $str = replace($str) if $str ~~ /'?'/;

    return $str;
}
