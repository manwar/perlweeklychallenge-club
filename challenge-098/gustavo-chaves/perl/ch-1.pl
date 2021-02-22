#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/
# TASK #1 › Read N-characters

use 5.030;
use warnings;
use Fcntl;

my ($FILE, @numbers) = @ARGV;

sub readN {
    my ($filename, $length) = @_;

    my ($fh, $buffer);

    state $cache = {};
    if (exists $cache->{$filename}) {
        $fh = $cache->{$filename};
    } else {
        if (sysopen($fh, $filename, O_RDONLY)) {
            $cache->{$filename} = $fh;
        } else {
            die "Failed to sysopen '$filename'\n";
        }
    }

    my $bytes_read = sysread($fh, $buffer, $length);
    if (! defined $bytes_read) {
        die "Failed to sysread '$filename'\n";
    } elsif ($bytes_read == 0) {
        delete $cache->{$filename};
    }

    return $buffer;
}

foreach my $number (@numbers) {
    print readN($FILE, $number), "\n";
}
