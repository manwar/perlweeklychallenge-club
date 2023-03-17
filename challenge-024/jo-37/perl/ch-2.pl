#!/usr/bin/perl

use v5.16;
use warnings;
use Data::Dump;
use experimental 'postderef';

### Input and Output

dd build_index(shift);


### Implementation

sub build_index {
    my %index;
    # Match words in the input string and record all starting positions.
    () = shift =~ /(\w+)(?{push $index{$^N}->@*, pos() - length($^N)})/g;
    \%index;
}
