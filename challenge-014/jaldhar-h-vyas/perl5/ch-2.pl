#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub makeWords {
    my ($list) = @_;

    open my $wordList, '<', $list or die "$list: $!\n";
    local $RS;
    my $contents = <$wordList>;
    close $wordList;
    return sort
           map { lc }
           grep { /^[[:alpha:]]+$/ }
           split /\n/,
           $contents;
}

my $wordList = shift // '/usr/share/dict/words';

my @words = makeWords($wordList);
my %spelled =  map { $_ => $_ } @words;

my @abbrevs = qw/
    al ak az ar ca co ct de fl ga hi id il in ia ks ky la me md ma mi mn ms mo
    mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy
/;

for my $word (@words) {
    for my $abbrev (@abbrevs) {
        if ($spelled{$word} eq q{}) {
            last;
        }
        if ($word =~ /$abbrev/) {
            $spelled{$word} =~ s/$abbrev//;
        }
    }
}

my $answer = q{};

for my $word (sort grep {$spelled{$_} eq q{}} keys %spelled) {
    if (length $word >= length $answer) {
        $answer = $word;
    }
}

say $answer;
