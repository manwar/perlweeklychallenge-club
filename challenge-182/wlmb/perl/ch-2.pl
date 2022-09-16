#!/usr/bin/env perl
# Perl weekly challenge 182
# Task 2:  Common Path
#
# See https://wlmb.github.io/2022/09/12/PWC182/#task-2-common-path
use v5.36;
use List::Util qw(all);
use List::MoreUtils qw(zip6);
use Cwd qw(getcwd);
my $dirs;
while(<>){
    canonical($_);
    my @parts=split '/';
    pop @parts;   # remove non-directory or empty at end
    $dirs=trim($dirs, @parts);
}
say join("/", @$dirs), "/";

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

sub trim($previous, @current){
    $previous=\@current unless defined $previous;
    my @new=map {$_->[0]}
        grep {(all {defined $_}(@$_)) && $_->[0] eq $_->[1]}
        zip6 @$previous, @current;
    return \@new;
}
