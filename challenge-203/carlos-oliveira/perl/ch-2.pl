use v5.36;
use strict;
use warnings;

use Const::Fast;

sub copy_only_directories;

sub copy_only_directories ($source, $target) {
  opendir(my $dir, $source) or die "Can't open directory: $source";
  while (my $entry = readdir $dir) {
    const my $source_entry => "$source/$entry";
    next unless -d $source_entry && $entry !~ /^[.]{1,2}$/;
    const my $dest_entry => "$target/$entry";
    mkdir $dest_entry or die "Can't create directory: $dest_entry";
    copy_only_directories $source_entry, $dest_entry;
  }
  closedir $dir;
}

unless (@ARGV == 2) {
  die "USAGE: $0 source/dir target/dir";
}

unless (-d $ARGV[1]) {
  mkdir $ARGV[1] or die "Can't create directory: $ARGV[1]";
}

copy_only_directories $ARGV[0], $ARGV[1];
