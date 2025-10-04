#!/usr/bin/perl
use 5.038;
use warnings;
use File::Find;
use File::Spec;

my ($source, $target) = @ARGV;
if (@ARGV != 2) {
    die "Usage: $0 source_dir target_dir\n";
}

unless (-d $target) {
    mkdir $target;
}

my @dirs;

find(
    {
        wanted => sub {
            if (-d) {
                push @dirs, $File::Find::name;
            }
        },
        no_chdir => 1,
    },
    $source
);

for my $dir (@dirs) {
    if ($dir eq $source) {
        next;
    }

    my $rel_path = File::Spec->abs2rel($dir, $source);
    my $new_dir = File::Spec->catdir($target, $rel_path);

    mkdir $new_dir;
}