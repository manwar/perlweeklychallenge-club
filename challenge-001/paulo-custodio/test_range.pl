#!/usr/bin/env perl

use Modern::Perl;
use Path::Tiny;

@ARGV==2 or die "usage: $0 start end\n";
my($start, $end) = @ARGV;

for my $challenge (path(".")->children(qr/^challenge-\d+$/)) {
    my($challenge_id) = ($challenge =~ /(\d+)/);
    next if $challenge_id < $start || $challenge_id > $end;
    for my $user ($challenge->children(qr/^paulo-custodio$/)) {
        say $user;
        chdir $user;
        my $res = system("make");
        chdir "../..";
        $res==0 or die "Test $challenge failed\n";
    }
}
