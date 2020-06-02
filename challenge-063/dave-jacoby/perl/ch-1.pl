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

my $json = JSON->new->canonical->allow_nonref->pretty->space_after;

say last_word();
say last_word( '  hello world',                qr/[ea]l/ ) || 'undef'; # 'hello'
say last_word( "Don't match too much, Chet!",  qr/ch.t/i ) || 'undef'; # 'Chet!'
say last_word( "spaces in regexp won't match", qr/in re/ ) || 'undef'; #  undef
say last_word( join( ' ', 1 .. 1e6 ), qr/^(3.*?){3}/ ) || 'undef';    # '399933'

sub last_word ( $string = ' strang string', $regex = qr/\w/ ) {
    my ($output) =
      reverse
      grep { /$regex/ }
      grep { /\S/ }
      split /\s+/, $string;
    return $output;
}
