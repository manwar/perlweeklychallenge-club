#!/usr/bin/perl
use 5.40.1;
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

sub makeBag(@array) {
    my %bag;
    for my $elem (@array) {
        $bag{$elem}++;
    }

    return %bag;
}

my %a = makeBag(split /\s+/, $ARGV[0]);
my %b = makeBag(split /\s+/, $ARGV[1]);

say scalar grep { $a{$_} == $b{$_} } intersection([keys %a], [keys %b]);
