# The Weekly Challenge 207
# Task 1 Keyboard Word
use v5.30.0;
use warnings;
use List::Util qw/uniq/;

sub kw {
    my @row = ("qwertyuiop", "asdfghjkl", "zxcvbnm");
    my @_row = map {join "", sort {$a cmp $b} split "", $_} @row;

    my @ans;
    my @words = @_;
    foreach my $word (@words) {
        my $_word = join "", uniq sort {$a cmp $b} split "", lc $word;
        push @ans, $word if subseq($_row[0], $_word);
        push @ans, $word if subseq($_row[1], $_word);
        push @ans, $word if subseq($_row[2], $_word);
    }
    return @ans;
}

sub subseq {
    # @mseq and @sseq are with distinct elements,
    # and sorted in the same way
    my $valid;
    my @mseq = split "", $_[0];
    my @sseq = split "", $_[1];
    my $i = 0;
    my $j = 0;
    while ($j < scalar @sseq) {
        if ($sseq[$j] lt $mseq[$i]) {
            $valid = 0;
            last;
        }
        if ($sseq[$j] eq $mseq[$i]) {
            $j++;
            $i++;
            $valid = 1;
        }
        last if $j > $#sseq || $i > $#mseq;
        $i++ if $sseq[$j] gt $mseq[$i];
        last if $i > $#mseq;
    }
    return 1 if $valid && $j == 1+$#sseq && $i <= 1+$#mseq;
    return 0;
}



say join " ", kw("Hello","Alaska","Dad","Peace", "OMG", "Bye");
