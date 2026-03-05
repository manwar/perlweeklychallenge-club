#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "Usage: $0 INT\n";
(my $int = shift) =~ /^\d+$/ or die "Usage: $0 INT\n";

if ($int =~ /((\d)\2\2+)/ && length($1) == 3) {
    say $1;
}
else {
    say -1;
}
