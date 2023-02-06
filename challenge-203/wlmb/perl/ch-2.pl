#!/usr/bin/env perl
# Perl weekly challenge 203
# Task 2:  Copy Directory
#
# See https://wlmb.github.io/2023/02/06/PWC203/#task-2-copy-directory
use v5.36;
die <<~"FIN" if @ARGV!=2;
    Usage: $0 dir1 dir2
    to copy the directory structure under dir1  to dir2
    FIN
copydir(@ARGV);
sub copydir($from, $to){
    opendir my $handle, $from || die "Couldn't open $from: $!";
    for(grep {!/^\./ && -d "$from/$_"} readdir($handle)){
	mkdir "$to/$_" || die "Couldn't create $to/$_";
	copydir("$from/$_", "$to/$_");
    }
}
