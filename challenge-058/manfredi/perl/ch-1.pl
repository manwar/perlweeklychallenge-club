#!/usr/bin/env perl
use strict;
use warnings;


sub compare($$) {
    my ($v1, $v2) = @_;
    my $cmp = 0;
    
    return $cmp if $v1 eq $v2;

    # To have lower precedence for underscore, use ascii code smaller than dot's ascii code
    $v1 =~ tr|_|-|;
    $v2 =~ tr|_|-|;
    
    # version with ascii number codes
    #my @v1 = map { ord } split '', $v1;
    #my @v2 = map { ord } split '', $v2;
    
    # Fills with zero until same length
    #push @v1, 0 while @v1 < @v2;
    #push @v2, 0 while @v2 < @v1;
    
    #while (@v1) {
    #    if ( $cmp = shift(@v1) <=> shift(@v2) ) {
    #        last;
    #    }
    #}

    # version with bare string compare 
    $cmp = $v1 cmp $v2;
    
    $cmp;
}

my %sig = ( '0' => '=', '1' => '>', '-1' => '<');
printf "%10s     %10s  %s\n", 'v1', 'v2', 'Result';
printf "%10s     %10s  %s\n", '-' x 10, '-' x 10, '-' x 6;

while (<DATA>) {
    chomp;
    my ($v1, $v2) = split /\s+/;
    my $cmp = compare($v1, $v2);
    printf "%10s  %s  %10s %5s\n", $v1, $sig{$cmp}, $v2, $cmp;
}


__DATA__
0.1     1.1
2.0     1.2   
1.2     1.2_5  
1.2.1   1.2_1
1.2.1   1.2.1
