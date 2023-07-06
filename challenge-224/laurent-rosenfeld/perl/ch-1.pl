use strict;
use warnings;
use feature 'say';

sub special_note {
    my ($source, $target) = @_;
    my %chars;
    $chars{$_}++ for split //, $source;
    for my $let (split //, $target) {
        return "false" unless $chars{$let};
        $chars{$let}--;
    }
    return "true";
}
for my $test ([ "abc", "xyz"],
    ["scriptinglanguage", "perl"],  ["aabbcc", "abc"] ) {
    printf "%-20s - %-7s => ", "@$test[0]", "@$test[1]";
    say special_note @$test[0], @$test[1];
}
