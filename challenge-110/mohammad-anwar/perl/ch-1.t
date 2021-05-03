#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( valid_phone_numbers('input-1.txt'),
          [ '0044 1148820341',
            ' +44 1148820341',
            '(44) 1148820341', ] );

done_testing;

sub valid_phone_numbers {
    my ($file) = @_;

    die "ERROR: Missing input file.\n" unless defined $file;

    open(my $fh, '<:encoding(utf8)', $file)
        or die "ERROR: Unable to open $file: $!\n";

    my $valid_phone_numbers = [];
    while (my $row = <$fh>) {
        chomp $row;

        if ( $row =~ / ( \+\d{2} | \(\d{2}\) | \d{4} ) \s \d{10} /x ) {
            push @$valid_phone_numbers, $row;
        }
    }

    close($fh);

    return $valid_phone_numbers;
}
