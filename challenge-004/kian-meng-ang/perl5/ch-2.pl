#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;

die "missing letters and dictionary file" if (@ARGV != 2);
my ($letters, $dict) = @ARGV;

my %chars;
++$chars{$_} for split '', $letters;

open (my $fh, '<:encoding(UTF-8)', $dict) or die "file: $dict not found";
while (my $word = <$fh>) {
    chomp $word;

    my %wchars;
    ++$wchars{$_} for split '', lc $word;

    my @mchars;
    while (my ($char, $count) = each (%chars)) {
        push @mchars, $char if (exists $wchars{$char} && $chars{$char} <= $wchars{$char});
    }
    if (scalar @mchars > 0) {
        my $rword = $word;
        $rword =~ s/$_/\[$_\]/ foreach @mchars;
        say sprintf "%s, %s", $word, $rword;
    }
}

1;

__END__
$ perl ch-2.pl qz /usr/share/dict/words | head
Agassiz, Agassi[z]
Agassiz's, Agassi[z]'s
Albuquerque, Albu[q]uerque
Albuquerque's, Albu[q]uerque's
Alcatraz, Alcatra[z]
Alcatraz's, Alcatra[z]'s
Alfonzo, Alfon[z]o
Alfonzo's, Alfon[z]o's
Algonquian, Algon[q]uian
Algonquian's, Algon[q]uian's

$ perl ch-2.pl qz /usr/share/dict/words | tail
zooms, [z]ooms
zoos, [z]oos
zucchini, [z]ucchini
zucchini's, [z]ucchini's
zucchinis, [z]ucchinis
zwieback, [z]wieback
zwieback's, [z]wieback's
zygote, [z]ygote
zygote's, [z]ygote's
zygotes, [z]ygotes

$ perl ch-2.pl se /usr/share/dict/words | grep "ee" | head
Aberdeen, Ab[e]rdeen
Aberdeen's, Ab[e]rdeen'[s]
Aileen, Ail[e]en
Aileen's, Ail[e]en'[s]
Aimee, Aim[e]e
Aimee's, Aim[e]e'[s]
Albee, Alb[e]e
Albee's, Alb[e]e'[s]
Appleseed, Appl[e][s]eed
Appleseed's, Appl[e][s]eed's

$ perl ch-2.pl se /usr/share/dict/words | grep "ee" | tail
windscreens, wind[s]cr[e]ens
wintergreen, wint[e]rgreen
wintergreen's, wint[e]rgreen'[s]
worksheet, work[s]h[e]et
worksheet's, work[s]h[e]et's
worksheets, work[s]h[e]ets
workweek, workw[e]ek
workweek's, workw[e]ek'[s]
workweeks, workw[e]ek[s]
yippee, yipp[e]e

# vi:et:sw=4 ts=4 ft=perl
