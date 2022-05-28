#!/usr/bin/perl
# The Weekly Challenge 166
# Task 2: K-Directory Diff
use v5.24.0;
use warnings;
use Cwd;
use List::Util qw/uniqstr any/;

kd(@ARGV) if defined($ARGV[1]);

my $TEMP_CWD = getcwd;



sub kd {

    my @dirs = @_;

    $_ =~ s/\/$// foreach @dirs;

    my @subdirs_gonna_p;
    my @files_gonna_p;


    # check whether the directories exist
    
    my $are_all_available = 1;

    for my $dirname (@dirs) {
        my $is_it_available = -e -d $dirname;
        warn "Directory \"$dirname\" does not exist!\n" if !$is_it_available;
        $are_all_available &&= $is_it_available; 
    }

    if (!$are_all_available) {
        say "Some directories do not exist!\n";
        return 0;
    }


    # scraping

    my %subdirs_of_dir;
    my %files_in_dir;

    for my $dirname (@dirs) {
        chdir $TEMP_CWD;
        chdir $dirname;
        $files_in_dir{$dirname}->@* = grep { ! -d $_ } glob("*");
        $subdirs_of_dir{$dirname}->@* = glob("*/");
    }


    # reposition 
    chdir $TEMP_CWD;


    # K-diff subdirectories

    my @subdirs = uniqstr map {$subdirs_of_dir{$_}->@*} @dirs;


    for my $dirname (@subdirs) {
        my $are_all_available = 1;
        for my $dir (@dirs) {
            my $is_it_available
                = any { $dirname eq $_ } $subdirs_of_dir{$dir}->@*;
            $are_all_available &&= $is_it_available;
            last if !$are_all_available;
        }
        push @subdirs_gonna_p, $dirname if !$are_all_available;
    }

    # K-diff files
    my @files = uniqstr map {$files_in_dir{$_}->@*} @dirs;

    for my $filename (@files) {
        my $are_all_available = 1;
        for my $dir (@dirs) {
            my $is_it_available
                = any { $filename eq $_ }
                     $files_in_dir{$dir}->@*;
            $are_all_available &&= $is_it_available;
            last if !$are_all_available;
        }
        push @files_gonna_p, $filename if !$are_all_available;
    }

    # Printing

    my $N = scalar @dirs;

    # return if the directories are "congruent"
    return 1 if (scalar @files_gonna_p == 0 && scalar @subdirs_gonna_p == 0);

    for my $dir (@dirs) {
        my_printf("%16s", $dir);
    }
    say "\n" . "-" x (16*$N);


    for my $dirname (@subdirs_gonna_p) {
        for my $dir (@dirs) {
            if (any {$dirname eq $_} $subdirs_of_dir{$dir}->@*) {
                my_printf("%16s", $dirname);
            }
            else {
                my_printf("%16s", "");   
            }
        }
        say "";
    }


    for my $filename (@files_gonna_p) {
        for my $dir (@dirs) {
            if (any {$filename eq $_} $files_in_dir{$dir}->@*) {
                my_printf("%16s", $filename);
            }
            else {
                my_printf("%16s", "");   
            }
        }
        say "";
    }

    # end subroutine
    return 1;
}



sub my_printf {
    my $w = $_[1];
    if (length $w > 14) {
        if (substr($_[1], -1, 1) eq "/") {
            $w = substr($w, 0, 12)."*/";
        }
        else {
            $w = substr($w, 0, 12)."**";
        }
    }
    if ( $w !~ /\*/ && $w =~ / / ) {
        $w = '"'.$w.'"'; 
    }
    printf($_[0], $w);
}



use Test::More tests => 4;
my $whoami = "cheok-yin-fung";
ok kd("../../../challenge-166/$whoami/perl", "../../../challenge-165/$whoami/perl");
ok kd("../../../challenge-166/$whoami/", "../../../challenge-165/$whoami/");
ok kd("../../../challenge-166/$whoami/", 
    "../../../challenge-165/$whoami/", 
    "../../../challenge-156/$whoami/");
ok kd("../../../challenge-166/$whoami/", "../../../challenge-163/$whoami/", 
    "../../../challenge-158/$whoami/", 
    "../../../challenge-147/$whoami/", "../../../challenge-110/$whoami/", 
    "../../../challenge-078/$whoami/", 
    "../../../challenge-077/$whoami/", "../../../challenge-075/$whoami/");

