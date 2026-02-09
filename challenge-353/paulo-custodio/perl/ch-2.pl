#!/usr/bin/env perl

use Modern::Perl;

chomp(my @codes = split /\s*,\s*/, <>);
chomp(my @names = split /\s*,\s*/, <>);
chomp(my @status = split /\s*,\s*/, <>);
my @result;
for my $i (0 .. $#codes) {
    push @result, check_values($codes[$i], $names[$i], $status[$i]) ?
                'true' : 'false';
}
say join ", ", @result;

sub check_values {
    my($code, $name, $status) = @_;
    return unless $code =~ /^\w+$/;
    return unless $name =~ /^(electronics|grocery|pharmacy|restaurant)$/;
    return unless $status eq 'true';
    return 1;
}
