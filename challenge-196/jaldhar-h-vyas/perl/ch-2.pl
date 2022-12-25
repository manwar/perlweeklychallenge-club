#!/usr/bin/perl
use 5.030;
use warnings;

my @array = @ARGV // die "need a list of integers separated by spaces";

my @allranges;
my $n = 0;

while ($n < scalar @array - 1) {
    my $r = $n;
    my @range = ( $array[$r] );
    until ($r == scalar @array - 1) {
        $r++;
        if ($array[$r] - $array[$r - 1] == 1) {
            push @range, $array[$r];
        } else {
            last;
        }
    }
    $n = $r;
    push @allranges, \@range;
}

@allranges =  map { "[$_->[0],$_->[-1]]"; } grep { scalar @{$_} > 1 } @allranges;
say join q{, }, @allranges;
