#!/usr/bin/env perl

# show stats of challenge submissions

use Modern::Perl;
use Path::Tiny;

my $USER = "paulo-custodio";

our %LANG = (
    ada     => 'adb',
    awk     => 'awk',
    basic   => 'bas',
    bc      => 'bc',
    c       => 'c',
    cpp     => 'cpp',
    d       => 'd',
    forth   => 'fs',
    lua     => 'lua',
    perl    => 'pl',
    python  => 'py',
);

# collect data
my @sols;
for my $chall_dir (path(".")->children(qr/challenge-\d+/)) {
    my($chall) = $chall_dir =~ /(\d+)/ or die;
    $chall += 0;

    for my $lang (sort keys %LANG) {
        my $dir = path($chall_dir, $USER, $lang);
        next unless $dir->is_dir;

        my $sols = scalar($dir->children(qr/^ch[-_]\d\.$LANG{$lang}$/));

        $sols[$chall]{$lang} = $sols;
    }
}

# output
for my $chall (1 .. $#sols) {
    if (($chall) % 10 == 1) {
        say "-" x 80;
        print " " x 4;
        for my $lang (sort keys %LANG) {
            print " ", $lang;
        }
        say "";
        say "-" x 80;
    }

    printf("%3d ", $chall);
    for my $lang (sort keys %LANG) {
        my $width = length($lang);
        my $before = int(($width-1)/2);
        my $after = $width - 1 - $before;
        my $value = $sols[$chall]{$lang} || " ";
        print " ", " " x $before, $value, " " x $after;
    }
    say "";
}
