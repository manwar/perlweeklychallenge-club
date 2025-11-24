use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my $moves = {
    'R' => sub($point) {
        $point->{'x'} += 1;
    },
    'L' => sub($point) {
        $point->{'x'} -= 1;
    },
    'U' => sub($point) {
        $point->{'y'} += 1;
    },
    'D' => sub($point) {
        $point->{'y'} -= 1;
    }
};

sub run($path) {
    my $point = {'x' => 0, 'y' => 0};
    do {
        my $operation = substr($path, 0, 1);
        $path = substr($path, 1);
        $moves->{$operation}->($point);
        return 1 if $point->{'x'} == 0 && $point->{'y'} == 0;
    } while(length($path));
    return 0;
}

is(run("ULD"), 0, "Example 1");
is(run("ULDR"), 1, "Example 2");
is(run("UUURRRDDD"), 0, "Example 3");
is(run("UURRRDDLLL"), 1, "Example 4");
is(run("RRUULLDDRRUU"), 1, "Example 5");
