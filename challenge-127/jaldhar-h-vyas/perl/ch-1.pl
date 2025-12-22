#!/usr/bin/perl
use 5.038;
use warnings;

sub intersection($arr1, $arr2) {
    my %count;

    for my $elem (@$arr1) {
        $count{$elem}++; 
    }

    my @result;

    for my $elem (@$arr2) {
        if ($count{$elem}) {
            push @result, $elem;
            $count{$elem}--;
        }
    }

    return @result;
}

my @S1 = split /,/, $ARGV[0];
my @S2 = split /,/, $ARGV[1];

say !scalar intersection(\@S1, \@S2) ? 1 : 0;

