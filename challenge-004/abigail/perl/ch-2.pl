#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl -f FILE < input-file
#

#
# The -f FILE determines the file to read words from.
# The input file contains sets of letters, one set per line.
#

use Getopt::Long;
GetOptions 'f=s'  =>  \my $file,
;

die "Usage: $0 -f FILE" unless defined $file;

sub find_words ($file, $letters) {
    return if $letters =~ /[^a-z]/i;
    open my $fh, "<", $file or die "open $file: $!";
    while (my $word = <$fh>) {
        chomp $word;
        #
        # Remove each letter from (a copy of) $word.
        # If we end up with an empty string, we can
        # from $word from the letters of $letters.
        #
        my $copy = $word;
        $copy =~ s/\Q$_//i for split // => $letters;
        length ($copy) or say $word;
    }
}


while (my $letters = <>) {
    chomp $letters;
    find_words $file => $letters;
}
