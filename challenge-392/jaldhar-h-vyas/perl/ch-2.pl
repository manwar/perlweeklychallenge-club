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

my @words = @ARGV;
my $longest = 0;

for my $i (1 .. scalar @words - 1) {
    for my $j (0 .. $i - 1) {
        if (scalar intersection([split //, $words[$i]], [split //, $words[$j]]) == 0) {
            my $len = length($words[$i]) * length($words[$j]);
            if ($len > $longest) {
                $longest = $len;
            }
        }
    }
}

say $longest;
