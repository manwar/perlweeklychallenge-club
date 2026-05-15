#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    $line =~ s/\s+//g;                               # Remove whitespace
    $line =~ s/\.//g;                                # Remove dots
    my @parts = split /;/ => $line;                  # Split on ;
    say $parts [0] eq $parts [1] ? "true" : "false"; # Equal?
}

__END__
