use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my @digits;
    my @chars;
    my $result;

    foreach my $c (split//, $string) {
        my $a = $c =~ /\d/ ? \@digits : \@chars;
        push @$a, $c;
    }

    my $digits_length = scalar(@digits);
    my $chars_length = scalar(@chars);

    return "" if abs($digits_length - $chars_length) > 1;

    @chars = sort { $a cmp $b } @chars;
    @digits = sort { $a cmp $b } @digits;

    my ($first, $second) = $digits_length < $chars_length ? (\@chars, \@digits) : (\@digits, \@chars);
    for (my $i = 0; $i < scalar(@$first); $i++) {
        $result .= $first->[$i];
        $result .= $second->[$i] if exists $second->[$i];
    }

    return $result;
}

is(run("a0b1c2"), "0a1b2c", "Example 1");
is(run("abc12"), "a1b2c", "Example 2");
is(run("0a2b1c3"), "0a1b2c3", "Example 3");
is(run("1a23"), "", "Example 4");
is(run("ab123"), "1a2b3", "Example 5");
