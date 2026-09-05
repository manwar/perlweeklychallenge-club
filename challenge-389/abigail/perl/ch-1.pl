#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my ($composer, @data, @out) = split /\s+/ => $line;
    @out [map {$_ - 1} @data [@data / 2 .. $#data]] = @data;
    say "\U$composer\E => @out";
}


__END__
