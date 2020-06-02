#!/usr/bin/env perl

# USAGE: ch-1.pl [-u] [file ...]

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

use Getopt::Long;
use Carp;
use JSON;

my $json   = JSON->new->canonical->allow_nonref->pretty->space_after;
my $data   = [];
my $unique = 0;
GetOptions( unique => \$unique );

if ( scalar @ARGV ) {
    for my $file (@ARGV) {
        if ( -f $file && open my $fh, '<', $file ) {

            # here might be the place for a looks_like_an_email
            # test, but oh, well...
            my @x = map { chomp $_; $_ } <$fh>;
            push $data->@*, @x;
        }
    }
}
else {
    $data->@* = map { chomp $_; $_ } <DATA>;
}

my @sorted = sort_email_addresses( $data, $unique );
say join "\n", @sorted;

sub sort_email_addresses ( $data, $unique = 0 ) {
    my $hash = {};
    my @output =

        map { $_->[0] }
        grep { !$unique || $hash->{ $_->[3] }++ < 1 }
        sort { fc $a->[2] cmp fc $b->[2] }
        sort { $a->[1] cmp $b->[1] }
        map { $_->[3] = join '@', $_->[1], fc $_->[2]; $_ }
        map { [ $_, split /\@/, $_ ] }
        map { chomp $_; $_ }

        $data->@*;
    return wantarray ? @output : \@output;
}

__DATA__
name@example.org
rjt@cpan.org
Name@example.org
rjt@CPAN.org
user@alpha.example.org
