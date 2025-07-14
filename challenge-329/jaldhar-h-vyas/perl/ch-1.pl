#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true /;
no warnings qw/experimental::builtin/;

sub orderedUnique(@list) {
    my @ordered;
    my %seen;

    for my $elem (@list) {
        unless (exists $seen{$elem}) {
            $seen{$elem} = true;
            push @ordered, $elem;
        }
    }

    return @ordered;
}

my $str = shift;
$str =~ s/\D/ /g;
$str =~ s/^\s+ || \s+$//g;

say join q{, }, orderedUnique(split /\s+/, $str);
