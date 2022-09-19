#!/usr/bin/env perl
use v5.24;
use warnings;

sub trim (&@) { my $cond = shift; grep { ! $cond->($_) } @_ }
sub trim_le ($@) { my $i = shift; trim { $_ <= $i } @_ }

my $i = shift // 3;
my @start = @ARGV ? @ARGV : (1, 4, 2, 3, 5);
my @trimmed = trim_le $i, @start;
{local $" = ','; say "(@trimmed)" }
