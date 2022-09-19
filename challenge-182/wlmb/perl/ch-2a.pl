#!/usr/bin/env perl
# Perl weekly challenge 182
# Task 2:  Common Path
#
# See https://wlmb.github.io/2022/09/12/PWC182/#task-2-common-path
use v5.36;
use Cwd qw(getcwd);
my $dirs;
while(<>){
    canonical($_);
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
sub canonical{
    for($_[0]){                         # localize $_
        s{^\s*}{};                      # remove leading space
        s{^([^/])}{getcwd . "/$1"}e;    # convert to absolute if relative
	s{/\./}{/}g;                    # /a/./->/a/
	1 while s{/[^/]*/\.\.(/|$)}{/}; # /a/b/../->/a/
        s{/\.\.(/|$)}{/}g;              # /..->/ at beginning
        1 while s{//}{/};               # //->/
    }
}
