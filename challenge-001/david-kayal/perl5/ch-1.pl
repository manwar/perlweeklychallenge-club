#!/usr/bin/perl

use warnings;
use strict;
use v5.10;

my $file_name = 'test_file_01';
my $data = `cat $file_name`;
chomp( $data );
my $count = &count_e( $data );
$data =~ s/e/E/mg;
say $data;
say $count;

sub count_e {
    my $data = shift;
    my @count = ( $data =~ /e/mg );
    return( scalar( @count ));
}
