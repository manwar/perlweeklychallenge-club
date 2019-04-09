#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my %base35;
my $counter = 0; # this is the counter.
for my $x ( 0..9 ) {
#    print $counter . "\t" . $x . "\n";
    $base35{ $counter } = $x;
    $counter++;
}
# print $counter . "\n";
for my $alpha ( 0..25 ) {
    my $letter = chr( 65 + $alpha );
    $base35{ $counter } = $letter;
    $base35{ $letter } = $counter;
#    print $letter . "\t" . $counter . "\n";
    $counter++;
} 
#-------------------------
my $number = 3501;
say $number . "\t" . &Base10toBase35( $number );
say '-' x 79;
my $b35number = '2u1';
say $b35number . "\t" . &Base35toBase10( $b35number );

sub Base35toBase10 {
    my $b35number = uc shift;
#    say $b35number;
    my @b35number = reverse split('', $b35number);
    my $_sum = 0;
    for( my $position = 0; $position < scalar(@b35number); $position++) {
	$_sum += $base35{ $b35number[$position] } * ( 35 ** $position );
	# print $b35number[$position] 
	#     . "\t"
	#     . $base35{ $b35number[$position] } * ( 35 ** $position ) . "\n";
    }
    return $_sum;
}

sub Base10toBase35 {
    my $number = shift;
    my @result;
    my $stop = 0;
    do{
	my $result0 = int($number / 35);
#	print $result0 . "\n";
	my $result1 = $number % 35;
#	print $result1 . "\n";
	$stop = 1 if $result0 <= 35;
	push @result, $base35{ $result1 };
	push @result, $base35{ $result0 } if( $stop );
	$number = $result0;
#	print '-' x 5 . "\n";
    }until( $stop );
    return( join '', reverse @result );
}

