#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 1;

sub square_secret_code {
    my $message = shift;
    my $cols = 8;

    $message =~ s/\s+//g;
    $message = lc($message);

    my $rows = int(length($message) / $cols) + 1;
    my $coded_message = "";

    for (my $i = 0; $i < $cols; $i++) {
        for (my $j = 0; $j < $rows; $j++) {
            my $index = $j * $cols + $i;
            if ($index < length($message)) {
                $coded_message .= substr($message, $index, 1);
            }
        }
        $coded_message .= " " if $i < $cols - 1;
    }

    return $coded_message;
}

sub run_test {
    my ($message, $expected_coded_message) = @_;
    my $coded_message = square_secret_code($message);
    is($coded_message, $expected_coded_message, "Testing: $message");
}

run_test("The quick brown fox jumps over the lazy dog", "tbjrd hruto eomhg qwpe unsl ifoa covz kxey");
