#!/usr/bin/env perl

use Modern::Perl;

sub draw {
    my($board, $hand) = @_;

    my %not_yet;
    for my $ball (split //, $board) {
        if ($board =~ /$ball[^$ball]+$ball/) {
            $not_yet{$ball} = 1;
        }
    }

    while ($board =~ /(.)\1/g) {
        my $ball = $1;
        if (!$not_yet{$ball} && $hand =~ /$ball/) {
            $board =~ s/$ball{2,}//;
            $board =~ s/(.)\1\1+//g;
            $hand =~ s/$ball//;
            return (1, $board, $hand);
        }
    }

    for my $ball (split //, $board) {
        if ($hand =~ /$ball/) {
            $board =~ s/$ball/$ball$ball/;
            $board =~ s/(.)\1\1+//g;
            $hand =~ s/$ball//;
            return (1, $board, $hand);
        }
    }

    return (0, $board, $hand);
}

sub play {
    my($board, $hand) = @_;
    my $rounds = 0;
    for (;;) {
        return $rounds if $board eq '';
        return -1 if $hand eq '';
        (my $moved, $board, $hand) = draw($board, $hand);
        return -1 if !$moved;
        $rounds++;
    }
}

say play(@ARGV);
