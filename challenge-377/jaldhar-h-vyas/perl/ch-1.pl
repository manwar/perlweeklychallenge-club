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

my $str = shift;

my @strsubs;
my @revsubs;

for my $i (0 .. (length $str) - 2) {
    my $sub = substr $str, $i, 2;
    push @strsubs, $sub;
    push @revsubs, scalar reverse $sub;
}

say scalar intersection(\@strsubs, \@revsubs) ? 'true' : 'false';