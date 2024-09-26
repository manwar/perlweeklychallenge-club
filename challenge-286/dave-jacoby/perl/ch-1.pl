#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ postderef say signatures state };

my $name = $0;
my $file = '';
if ( open my $fh, '<', $name ) {
    $file = join '', <$fh>;
    my @file = split /\s+/, $file;
    say $file[ rand scalar @file ] ;
}
else { exit }
