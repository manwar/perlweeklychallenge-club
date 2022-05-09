use strict;
use warnings;
use feature "say";

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub summations {
    my @result = @_;
    for (1..$#result) {
        my @temp;
        push @temp, sum (@result[1..$_]) for 1..$#result;
        @result = @temp;
        return $result[0] if @result == 1;
    }
}
for my $test ([qw <1 2 3 4 5>], [qw <1 3 5 7 9>]) {
    say "@$test -> ", summations @$test;
}
