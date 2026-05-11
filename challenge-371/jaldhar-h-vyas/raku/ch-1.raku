#!/usr/bin/raku

sub isValidSequence(@seq) {
    my @positions = @seq.map({ $_.ord - q{`}.ord });
    my @steps = (0 .. 3).map({ @positions[$_ + 1] - @positions[$_] });
    
    if @steps.all == @steps[0] {
        return True;
    }
    
    if @steps[0] == @steps[2] && @steps[1] == @steps[3] {
        return True;
    }
    
    return False;
}

sub findMissing(@seq) {
    my @chars = @seq;
    my $unknownPos = -1;

    for @chars.keys -> $pos {
        if @chars[$pos] eq '?' {
            $unknownPos = $pos;
            last;
        }
    }

    if $unknownPos == -1 {
        return '?';
    }
    
    for 'a' .. 'z' -> $letter {
        @chars[$unknownPos] = $letter;
        if isValidSequence(@chars) {
            return $letter;
        }
    }
    
    return '?';
}

sub MAIN(*@seq) {
    say findMissing(@seq);
}
