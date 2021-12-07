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
    brainfuck=>'pl', #'bf',
    c       => 'c',
    cpp     => 'cpp',
    d       => 'd',
    forth   => 'fs',
    fortran => 'f90',
    lua     => 'lua',
    pascal  => 'pas',
    perl    => 'pl',
    python  => 'py',
);

for my $chall_dir (path(".")->children(qr/challenge-\d+/)) {
    my($chall) = $chall_dir =~ /(\d+)/ or die;
    $chall += 0;

    for my $lang (sort keys %LANG) {
        my $dir = path($chall_dir, $USER, $lang);
        next unless $dir->is_dir;

        for my $sol ($dir->children(qr/^ch[-_]\d\.$LANG{$lang}$/)) {
            my $text = $sol->slurp;
            if ($text !~ /Challenge 0*$chall\b/) {
                say $sol;
            }
        }
    }
}
