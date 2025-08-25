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

my (@words) = @ARGV;

my @letters = split //, shift @words;

for my $word (@words) {
    @letters = intersection(\@letters, [split //, $word]);
}

say q{(}, (join q{, }, map { "\"$_\"" } sort @letters ), q{)};