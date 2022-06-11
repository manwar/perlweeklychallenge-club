#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @samples;
push @samples, '978-0-306-40615-7';    # error-correction coding
                                       # for digital communication
push @samples, '978-0596001735';       # perl best practices
push @samples, '978-0596003135';       # perl cookbook
push @samples, '978-0596004927';       # programming perl
push @samples, '978-1492094951';       # learning perl
push @samples, '978-1680500882';       # modern perl

for my $sample (@samples) {
    my $check = find_check_digit($sample);
    say <<"END";
    ISBN-13: $sample
    Check:   $check
END
}

sub find_check_digit( $isbn13) {
    my @digits = $isbn13 =~ /(\d)/gmix;
    pop @digits;
    push @digits, 0;
    my @x = map { $_ % 2 == 1 ? 3 * $digits[$_] : $digits[$_] } 0 .. 12;
    return 10 - ( ( sum0 @x ) % 10 );
}
