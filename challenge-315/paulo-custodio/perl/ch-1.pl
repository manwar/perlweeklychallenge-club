#!/usr/bin/env perl

use Modern::Perl;

my @words = split ' ', <>;
chomp(my $char = <>);

say "(", join(", ", indices_words($char, @words)), ")";

sub indices_words {
    my($char, @words) = @_;
    my @indices;
    for my $i (0 .. $#words) {
        if ($words[$i] =~ /$char/) {
            push @indices, $i;
        }
    }
    return @indices;
}
