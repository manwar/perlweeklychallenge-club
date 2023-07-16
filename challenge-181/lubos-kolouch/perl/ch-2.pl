#!/usr/bin/perl
use strict;
use warnings;

sub hot_days {
    my $filename = shift;
    open my $fh, '<', $filename or die "Could not open file '$filename' $!";

    my %temps;
    while ( my $line = <$fh> ) {
        chomp $line;
        my ( $date, $temp ) = split /, /, $line;
        $temps{$date} = $temp;
    }
    close $fh;

    my $prev_temp = -1;
    for my $date ( sort keys %temps ) {
        if ( $temps{$date} > $prev_temp ) {
            print "$date\n";
            $prev_temp = $temps{$date};
        }
    }
}

hot_days('temperature.txt');
