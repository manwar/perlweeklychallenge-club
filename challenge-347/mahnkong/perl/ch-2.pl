use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($phone) {
    my @parts;
    $phone =~ s/\D//g;
    while (length($phone)) {
        my $block_length = (length($phone) == 4 || length($phone) == 2) ? 2 : 3;
        push @parts, substr($phone, 0, $block_length);
        $phone = substr($phone, $block_length, length($phone));

    }
    return join("-", @parts);
}

is(run("1-23-45-6"), "123-456", "Example 1");
is(run("1234"), "12-34", "Example 2");
is(run("12 345-6789"), "123-456-789", "Example 3");
is(run("123 4567"), "123-45-67", "Example 4");
is(run("123 456-78"), "123-456-78", "Example 5");
