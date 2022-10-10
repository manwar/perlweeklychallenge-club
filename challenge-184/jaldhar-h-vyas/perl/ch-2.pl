#!/usr/bin/perl
use 5.030;
use warnings;

sub printArray {
    my ($array) = @_;

    my @output = map { q{[} . (join q{,}, @{$_}) . q{]} } @{$array};

    return q{[} . (join q{, }, @output) . q{]};
}

my @list = @ARGV;
my @allInts;
my @allAlphas;

for my $string (@list) {
    my @ints;
    my @alphas;

    for my $char (split q{ }, $string) {
        if ($char =~ /[0-9]/) {
            push @ints, $char;
        } elsif ($char =~ /[a-z]/) {
            push @alphas, "'$char'";
        }
    }

    if (@ints) {
        push @allInts, \@ints;
    }
    if (@alphas) {
        push @allAlphas, \@alphas;
    }
}

say printArray(\@allInts), ' and ', printArray(\@allAlphas);
