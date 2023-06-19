use strict;
use warnings;
use feature 'say';

sub find_good {
    my ($string, @words) = @_;
    # say $string, " - ", "@words";
    my $length = 0;
    my %chars;
    $chars{$_}++ for split //, $string;
    WORD: for my $word (@words) {
        my %char_cpy = %chars;
        for my $let (split //, $word) {
            next WORD unless $char_cpy{$let};
            $char_cpy{$let}--;
        }
        $length += length $word;
    }
    return $length
}
for my $test (
    ["atach", [<cat bt hat tree>]],
    ["atach", [<cat bt hat tree cata>]],
    ["atach", [<cat bt hat tree ataca>]],
    ["welldonehopper", [<hello world challenge>]]) {
    printf "%-15s - %-22s => ", "@$test[0]", "@{@$test[1]}";
    say find_good  @$test[0], @{@$test[1]};
}
