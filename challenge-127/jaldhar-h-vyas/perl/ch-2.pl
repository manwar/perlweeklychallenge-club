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

my @intervals = map { [ $_->[0] .. $_->[1] ]} map { [split /,/] } @ARGV;
my @overlaps;

for my $i (1 .. scalar @intervals - 1) {
    for my $j (0 .. $i - 1) {
        if (scalar intersection($intervals[$i], $intervals[$j])) {
            push @overlaps, [$intervals[$i]->[0], $intervals[$i]->[-1]];
            last;
        }
    }
}

say '[ ', ( join q{, }, map { q{(} . ( join q{,}, @{$_} ) . q{)} } @overlaps ), ' ]';
