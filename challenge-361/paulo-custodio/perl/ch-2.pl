#!/usr/bin/env perl

use Modern::Perl;

my @m = parse_matrix();
say find_celebrity(@m);

sub parse_matrix {
    my @m;
    while (<>) {
        push @m, [split ' ', $_];
    }
    return @m;
}

sub find_celebrity {
    my(@m) = @_;
CANDIDATE:
    for my $celeb (0 .. $#m) {
        # knows no one
        for my $person (0 .. $#m) {
            next if $person == $celeb;
            next CANDIDATE if $m[$celeb][$person];
        }
        # every one knows
        for my $person (0 .. $#m) {
            next if $person == $celeb;
            next CANDIDATE if !$m[$person][$celeb];
        }

        return $celeb;
    }
    return -1;
}
