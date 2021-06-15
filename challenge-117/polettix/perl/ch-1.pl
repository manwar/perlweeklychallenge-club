#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub missing_row ($file) {
   open my $fh, '<', $file or die "open('$file'): $!\n";
   my %all = map {$_ => 1} 1 .. 15;
   delete $all{s{\A (\d+) .*}{$1}rmxs} while <$fh>;
   return keys %all;
}

say missing_row($ARGV[0]);
