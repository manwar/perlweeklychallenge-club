package Calc;

use strict;
use warnings;

sub new { bless {}, shift; }
sub add { }
sub mul { }
sub div { }

1;

package main;

{
    no strict 'refs';

    my $class = 'Calc';
    for my $name ( sort keys %{ $class . '::' } ) {
        next if $name eq 'BEGIN';     # skip special symbol
        next if $name eq 'import';    # skip import() method
        next unless defined &{ $class . '::' . $name };
        print "$name\n";
    }
}
