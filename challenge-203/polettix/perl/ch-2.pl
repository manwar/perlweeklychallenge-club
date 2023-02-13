#!/usr/bin/env perl
use v5.24;
use warnings;
use English '-no_match_vars';
use experimental 'signatures';
no warnings 'experimental::signatures';

use File::Spec::Functions qw< splitpath splitdir catdir catpath >;
use File::Path qw< make_path >;

copy_directory(@ARGV);

sub copy_directory ($from, $to) {
   my ($fv, $fds) = splitpath($from, 'no-file');
   my ($tv, $tds) = splitpath($to, 'no-file');
   opendir my $dh, $from or die "opendir('$from'): $OS_ERROR";
   for my $item (readdir($dh)) {
      next if ($item eq '.') || ($item eq '..');
      my $source = catpath($fv, $fds, $item);
      next unless -d $source;
      my (undef, undef, $mode) = stat($source);
      my $target = catpath($tv, $tds, $item);
      make_path($target, {mode => $mode});
      __SUB__->($source, $target);
   }
}
