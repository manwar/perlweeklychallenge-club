#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ max };

my @message_sets = (['Hxl4!', 'ce-lo', 'ze6lg', 'HWlvR', 'q9m#o'],
                    ['P+2l!ato', '1e80R$4u', '5-r]+a>/', 'Pxwlb3k\\',
                     '2e35R8yu', '<!r^()k0']);

for my $messages (@message_sets) {
    my @frequency;
    for my $message (@$messages) {
        ++$frequency[$_]{ substr $message, $_, 1 }
            for 0 .. length($message) - 1;
    }
    for my $position (@frequency) {
        my $max = max(values %$position);
        $position->{$_} == $max and print for keys %$position;
    }
    print "\n";
}
