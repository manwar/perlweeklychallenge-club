#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    # Define a variable
    my $var;

    # Display its location
    say \$var =~ /(0x[0-9a-f]+)/;
}

main();
