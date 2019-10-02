#!/bin/env perl

use Modern::Perl;

die "usage: $0 <file-name>\n" unless @ARGV == 1;

open(my $fh, '<', $ARGV[0]) or die "cannot open $ARGV[0] for read\n";
my $buf;
read $fh, $buf, 16;

my $be_ascii = 1;
for my $c (split //, $buf) {
    unless (is_ascii($c)) {
        $be_ascii = 0;
        last;
    }
}

print 'the file content is ';
say $be_ascii ? 'ascii' : 'binary';

close $fh;

sub is_ascii {
    my $c = ord(shift);

    return 1 if 9  <= $c and $c <= 13;
    return 1 if 32 <= $c and $c <= 126;
    return 0;
}
