use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub inc($number) { return $number += 1; }
sub dec($number) { return $number -= 1; }

my %ops_map = ('x++' => \&inc, '++x' => \&inc, 'x--' => \&dec, '--x' => \&dec);

sub run(@operations) {
    my $result = 0;
    foreach my $operation (@operations) {
        $result = $ops_map{$operation}->($result) if exists $ops_map{$operation};
    }
    return $result;
}

is(run("--x", "x++", "x++"), 1, "Example 1");
is(run("x++", "++x", "x++"), 3, "Example 2");
is(run("x++", "++x", "--x", "x--"), 0, "Example 3");
