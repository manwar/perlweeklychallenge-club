use strict;
use warnings;
use feature 'say';

sub common_char {
    my %histo;
    my @in = map lc $_, @_;
    for my $word (@in) {
        my %unique = map { $_ => 1 } split //, $word;
        $histo{$_}++ for keys %unique;
    }
    return sort grep { $histo{$_} == scalar @in } keys %histo;
}

for my $test ([<Perl Rust Raku>], [<love live leave>]) {
  printf "%-15s => ", "@$test";
  say join " ", common_char @$test;
}
