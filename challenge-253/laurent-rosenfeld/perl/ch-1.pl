use strict;
use warnings;
use feature 'say';

sub split_strings {
    my ($sep, @strings) = @_;
    $sep = quotemeta $sep;
    my @result = grep { /\w+/ }
        map { split $sep, $_ } @strings;
    return @result;
}

my @tests = ( [ '.', ["one.two.three","four.five","six"] ],
              [ '$', ['$perl$$', '$$raku$'] ] );
for my $test (@tests) {
    printf "%-30s => ",  "@{$test->[1]}";
    say join " ", split_strings $test->[0], @{$test->[1]};
}
