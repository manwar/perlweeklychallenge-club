#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

# I'm assuming the list of allowed letters is given on the command line and the
# list of words is in a file in the current directory called word.list.
# This wasn't clear in the spec.

sub usage {
    print <<"-USAGE-";
    Usage:
    $PROGRAM_NAME <letters>

    <letters>    A case-insensitive string of letters to be matched.
                 Can include repeats.
-USAGE-

    exit(1);
}

if (scalar @ARGV < 1) {
    usage();
}

my $letters = $ARGV[0];

open my $wordList, '<', 'word.list' or die "word.list: $!\n";
local $RS;
my $contents = <$wordList>;
close $wordList;
my @words = split /\n/, $contents;


foreach my $word (@words) {
    my $upword = uc $word;  # converting word and letter list to upper case
    my $used = uc $letters; # for case-insensitive comparisons.
    my $bogus = undef;
    for my $letter (split //, $upword) {
        if ($used !~ s/$letter//) {
            $bogus = 1;
            last;
        }
    }

    if (!$bogus) {
        say $word;
    }
}

