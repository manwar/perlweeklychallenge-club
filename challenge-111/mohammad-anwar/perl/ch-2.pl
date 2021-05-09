#!/usr/bin/perl

use strict;
use warnings;

my $dict = $ARGV[0];
die "ERROR: Missing dictionary file.\n" unless defined $dict;

open (my $fh, '<:encoding(utf8)', $dict)
    or die "ERROR: Unable to open $dict: $!\n";

my ($max_length, $max_word) = 0;
while (my $word = <$fh>) {
    chomp $word;
    my $l = length($word);

    next if $l == 1;
    $word =~ s/\'//;
    next unless (lc $word eq (join '', sort split //, lc $word));

    if ($l > $max_length) {
        $max_word = $word;
        $max_length = $l;
    }
}
close($fh);

print "Max word: $max_word\n";
