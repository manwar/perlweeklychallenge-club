#!/usr/bin/perl
use warnings;
use strict;

use Path::Tiny qw{ path };
use Text::Table;

my @dirs = @ARGV;
my %files_in;
for my $dirname (@dirs) {
    my $dir = path($dirname);
    for my $child (sort $dir->children) {
        push @{ $files_in{$dirname} },
            $child->basename . ($child->is_dir ? '/' : "");
    }
}

my $table = 'Text::Table'->new(\'|', map { $_, \'|' } @dirs);

while (grep @$_, values %files_in) {
    my %count;
    ++$count{$_->[0]} for grep defined $_->[0], values %files_in;

    if (1 == keys %count && (values %count)[0] == @dirs) {
        shift @$_ for values %files_in;
        next
    }

    my $first = (sort keys %count)[0];
    my @row;
    for my $dir (@dirs) {
        if (($files_in{$dir}[0] // "") eq $first) {
            push @row, shift @{ $files_in{$dir} };
        } else {
            push @row, "";
        }
    }
    $table->add(@row);
}

print $table->title,
      $table->rule('-'),
      $table->body;

