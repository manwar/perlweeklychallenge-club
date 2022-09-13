#!/usr/bin/env perl
# Perl weekly challenge 182
# Task 2:  Common Path
#
# See https://wlmb.github.io/2022/09/12/PWC182/#task-2-common-path
use v5.36;
use List::Util qw(all);
use List::MoreUtils qw(zip6);
my $dirs;
while(<>){
    die "Not an absolute directory: $_" unless m(^\s*/);
    my @parts=split '/';
    shift @parts; # remove empty string at start
    pop @parts;   # remove non-directory or empty at end
    $dirs=trim($dirs,"", @parts);
}
say join("/", @$dirs), "/";

sub trim($previous, @current){
    $previous=\@current unless defined $previous;
    my @new=map {$_->[0]}
        grep {(all {defined $_}(@$_)) && $_->[0] eq $_->[1]}
#        grep {defined $_->[0] && defined $_->[1] && $_->[0] eq $_->[1]}
        zip6 @$previous, @current;
    return \@new;
}
