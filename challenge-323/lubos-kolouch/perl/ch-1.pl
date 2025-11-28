#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Increment Decrement (Weekly Challenge 323)

Starting from 0, apply each operation (++x, x++, --x, x--) and return
the final value.

=cut

sub final_value (@ops) {
    my $value = 0;
    for my $op (@ops) {
        if ($op =~ /\+\+/) {
            $value++;
        }
        elsif ($op =~ /--/) {
            $value--;
        }
    }
    return $value;
}

if (!caller) {
    require Test::More;
    Test::More::is( final_value('--x', 'x++', 'x++'), 1, 'Example 1' );
    Test::More::is( final_value('x++', '++x', 'x++'), 3, 'Example 2' );
    Test::More::is( final_value('x++', '++x', '--x', 'x--'), 0, 'Example 3' );
    Test::More::done_testing();
}
