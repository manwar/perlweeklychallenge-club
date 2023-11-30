use strict;
use warnings;
use feature 'say';

sub sort_lang {
    my @lang = @{$_[0]};
    my @pop  = @{$_[1]};
    return join " ",  @lang[map {$_ - 1} @pop];
}

my @tests =
    ({ lang => [<perl c python>],    pop => [2, 1, 3]},
     { lang => [<c++ haskell java>], pop => [1, 3, 2]});

for my $test (@tests) {
    printf "%-22s", "@{$test->{lang}} => ";
    say sort_lang $test->{lang}, $test->{pop};
}
