#!/usr/bin/env perl
# Perl weekly challenge 182
# Task 2:  Common Path
#
# See https://wlmb.github.io/2022/09/12/PWC182/#task-2-common-path
use v5.36;
my $dirs;
while(<>){
    die "Not an absolute directory: $_" unless m(^\s*/);
    my @parts=split '/';
    pop @parts;   # remove non-directory or empty at end
    my $d=$dirs->{shift @parts}//={};
    $d=$d->{$_}//={} foreach(@parts); # create/update and traverse hash of hashes
}
my $d=$dirs->{""};
print "/";
while(1){
    my @subdirs=keys %$d;
    say(""), last unless @subdirs==1;
    print "@subdirs/";
    $d=$d->{"@subdirs"}
}
