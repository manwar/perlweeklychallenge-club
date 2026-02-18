#!/usr/bin/env perl

use Modern::Perl;

my @n1 = split ' ', <>;
my @n2 = split ' ', <>;
say min_common(\@n1, \@n2);

sub min_common {
    my($n1, $n2) = @_;
    my %n1;
    my @common;
    for (@$n1) { $n1{$_} = 1; }
    for (@$n2) { push @common, $_ if $n1{$_}; }
    @common = sort {$a<=>$b} @common;
    return @common==0 ? -1 : $common[0];
}
