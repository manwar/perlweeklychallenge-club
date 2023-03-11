use strict;
use warnings;
use feature "say";

my @rows;
push @rows, {map {$_ => 1} split //, $_}
    for "qwertyuiop", "asdfghjkl", "zxcvbnm";

for my $test ([<Hello Alaska Dad Peace>], [<OMG Bye>],
    [<Power Fad Finish Tower Quit True Omit>]) {
    say join " ", find_kb_word(@$test);
}

sub find_kb_word {
    my @out;
    for my $word (@_) {
        for my $row (@rows) {
            my $eligible = 1;
            push @out, $word and last
                unless grep {not exists $row->{$_}}
                split //, lc $word;
        }
    }
    return @out ? @out : "()";
}
