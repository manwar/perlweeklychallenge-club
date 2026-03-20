#!/usr/bin/env perl

# Perl Weekly Challenge 224 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-224/

use Modern::Perl;

@ARGV==1 or die "Usage: $0 num\n";
my $num = shift;
my $result = 0;
is_addictive_seq(\$result, [], $num);
say $result ? "true" : "false";

sub is_addictive_seq {
    my($result, $seq, $num) = @_;

    if (@$seq >= 3 && $seq->[-3]+$seq->[-2]!=$seq->[-1]) {
        return;                 # not a sequence
    }
    elsif (@$seq >= 3 && $num eq '') {
        $$result = 1;           # found solution
        return;
    }
    elsif ($num eq '') {
        return;                 # no solution
    }
    else {                      # add one more number to sequence
        for my $i (1..length($num)) {
            is_addictive_seq($result, [@$seq, 0+substr($num,0,$i)], substr($num,$i));
        }
    }
}
