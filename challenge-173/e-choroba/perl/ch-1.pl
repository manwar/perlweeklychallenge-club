#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

{   my @positive_groups;
    for my $digit1 (0 .. 9) {
        my @digits2 = grep 1 == abs($digit1 - $_), 0 .. 9;
        push @positive_groups, do { local $" = ""; "$digit1(?=[@digits2]|\$)" };
    }
    my $esthetic_number_regex = join '|', @positive_groups;
    $esthetic_number_regex = qr/^(?:$esthetic_number_regex)+$/;

    # /o is not recommended, but it makes the solution significantly faster.
    sub esthetic_number ($n) { $n =~ /$esthetic_number_regex/o }
}

{   my @negative_groups;
    for my $digit1 (0 .. 9) {
        my @digits2 = grep 1 != abs($_ - $digit1), 0 .. 9;
        push @negative_groups, $digit1 . '[' . join("", @digits2) . ']';
    }
    my $not_esthetic_number = join '|', @negative_groups;

    sub esthetic_number2 ($n) { $n !~ /$not_esthetic_number/o }
}

use Test::More tests => 4;

ok esthetic_number(5456), 'Example 1 positive';
ok ! esthetic_number(120), 'Example 2 positive';

ok esthetic_number2(5456), 'Example 1 negative';
ok ! esthetic_number2(120), 'Example 2 negative';

use Benchmark qw{ cmpthese };

cmpthese(-3, {
    positive => 'esthetic_number(12345678), esthetic_number(1234568)',
    negative => 'esthetic_number2(12345678), esthetic_number2(1234568)',
});

__END__

             Rate negative positive
negative 193425/s       --     -22%
positive 247679/s      28%       --
