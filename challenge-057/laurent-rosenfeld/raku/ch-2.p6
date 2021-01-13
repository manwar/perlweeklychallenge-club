use v6;

my @words = <alphabet foo book carpet cadmium cadeau alpine foxtrot>;
my @prefixes;
my %letters;
%letters.push(substr($_, 0, 1) =>  $_) for @words;
for %letters.keys.sort -> $let {
    push @prefixes, $let and next if %letters{$let}.elems == 1;
    my $candidate;
    for %letters{$let}.flat -> $word {
        for 2..$word.chars -> $i {
            my $cand = substr $word, 0, $i;
            my $count = %letters{$let}.grep({$cand eq substr($_, 0, $i)}).elems;
            push @prefixes, $cand and last if $count == 1;
        }
    }
}
say @prefixes;
