#!/usr/bin/perl
use v5.22.0;
use warnings;
use List::Util qw/sum any/;

my $happiness = $ARGV[0] || 8;
my $counter = 0;
my $n = 1;

while ( $counter < $happiness ) {
    if (verify_happy($n)) {
        $counter++;
        say $n;
    }
    $n++;
}


sub verify_happy {
    my $number = $_[0];
    my @arr;
    while ($number > 999) {
        @arr = split "", $number;
        $number = sum map {$_**2} @arr;
    }

    my @appeared;
    my $loop_control = 244;  # 243 = 9**2 + 9**2 + 9**2
    do {
        return 1 if $number == 1;
        @arr = split "", $number;
        $number = sum map {$_**2} @arr;
        return 0 if any {$number == $_} @appeared;
        push @appeared, $number;
        $loop_control--;
    } while ($loop_control>0); 
    return 0;
}
