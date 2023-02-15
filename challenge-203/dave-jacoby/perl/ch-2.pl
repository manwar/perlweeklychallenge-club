#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Getopt::Long;

my $source  = './a/b/c';
my $target  = './x/y';
my $verbose = 0;

GetOptions(
    'source=s' => \$source,
    'target=s' => \$target,
    'verbose'  => \$verbose,
);

copy_directory( $source, $target );

sub copy_directory ( $source, $target ) {
    return unless -d $source;
    return unless -d $target;
    my @dirs;
    if ( opendir my $dh, $source ) {
        for my $f ( sort readdir $dh ) {
            my $s = join '/', $source, $f;
            my $t = join '/', $target, $f;
            next if $f =~ /^\./;
            next unless -d $s;
            next if -d $t;
            mkdir $t;
            copy_directory( $s, $t );
            say join ' => ', $s, $t if $verbose;
        }
    }
}
