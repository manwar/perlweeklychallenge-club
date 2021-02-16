#!/usr/bin/perl

# Perl Weekly Challenge - 098
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/
#
# Task 1 - Read N-characters
#
# Author: Niels 'PerlBoy' van Dijke

package readN;

use v5.16;
use strict;
use warnings;

use Fcntl qw(:DEFAULT);
use Time::HiRes qw(usleep);

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(readN);

my %FH;
my %EOF;

sub readN ($$) {
  my ($fileName, $length) = @_;

  # Close the file when eof is reached
  if (exists $EOF{$fileName}) {
    delete $FH{$fileName};
    delete $EOF{$fileName};
    return;
  }

  if (!exists ($FH{$fileName})) {
    sysopen($FH{$fileName}, $fileName, O_RDONLY) //
      die "Can't open '$fileName' ($!)";
    binmode($FH{$fileName});
  }

  my $return;
  my $retry = 10;
  do {
    my $buf;
    my $nread = sysread($FH{$fileName}, $buf, $length);
    if (!defined $nread) {
      $retry--; usleep 1_000;
    } elsif ($nread == 0) {
      $EOF{$fileName}++;
    } elsif ($nread <= $length) {
      $return .= $buf;
    }
  } while (!exists  $EOF{$fileName} and length($return // '') != $length and $retry);

  return $return;
}

1; 
