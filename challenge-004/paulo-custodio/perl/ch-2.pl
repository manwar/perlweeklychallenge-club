#!/usr/bin/perl

# Challenge 004
#
# Challenge #2
# You are given a file containing a list of words (case insensitive 1 word per
# line) and a list of letters. Print each word from the file that can be made
# using only letters from the list. You can use each letter only once (though
# there can be duplicates and you can use each of them once), you don't have to
# use all the letters.
# (Disclaimer: The challenge was proposed by Scimon Proctor)

use Modern::Perl;

@ARGV==1 or die "Usage: ch-2.pl letters\n";
my($letters) = @ARGV;

$letters = lc($letters);

open(my $fh, "<", "words.txt") or die "open words.txt: $!\n";
while (<$fh>) {
    chomp;
    next if /\W/;
    next if length($_) < 2;
    say $_ if matches($_, $letters);
}

sub matches {
    my($word, $letters) = @_;
    for my $c (split //, $letters) {
        $word =~ s/$c//;
        return 1 if $word eq '';
    }
    return 0;
}
