#!/usr/bin/perl
use 5.40.1;
use warnings;

sub isValidSequence(@seq) {
    my @positions = map { ord($_) - ord(q{`}) } @seq;
    my @steps = map { $positions[$_ + 1] - $positions[$_] } 0 .. 3;
    
    unless (grep { $_ == $steps[0] } @steps) {
        return true;
    }
    
    if ($steps[0] == $steps[2] && $steps[1] == $steps[3]) {
        return true;
    }
    
    return false;
}

sub findMissing(@seq) {
    my @chars = @seq;
    my $unknownPos = -1;

    for my $pos (keys @chars) {
        if ($chars[$pos] eq '?') {
            $unknownPos = $pos;
            last;
        }
    }

    if ($unknownPos == -1) {
        return '?';
    }
    
    for my $letter ('a' .. 'z') {
        $chars[$unknownPos] = $letter;
        if (isValidSequence(@chars)) {
            return $letter;
        }
    }
    
    return '?';
}

say findMissing(@ARGV);

