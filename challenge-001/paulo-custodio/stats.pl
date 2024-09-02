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
    brainfuck=>'bf',
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

# challenge 232 did not happen
for my $lang (sort keys %LANG) {
    $sols[232]{$lang} = 2;
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

say "";

for my $lang (sort keys %LANG) {
    my @list;
    my $count=0;
    for my $chall (1 .. $#sols) {
        push @list, $chall if ($sols[$chall]{$lang}//0)==2;
        $count+=$sols[$chall]{$lang}//0;
    }
    say sprintf("%-12s(%4d) ", $lang, $count), list_compreension(@list);
}

sub list_compreension {
    my(@in) = @_;
    my @out;
    while (@in) {
        if (@in==1) {
            push @out, shift @in;
        }
        else {
            my $i=0;
            while ($i<@in && $in[$i]==$in[0]+$i) { $i++; }
            if ($i==1) {
                push @out, shift @in;
            }
            else {
                push @out, $in[0]."-".$in[$i-1];
                splice(@in,0,$i);
            }
        }
    }
    return join(",", @out);
}
