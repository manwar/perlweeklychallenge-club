#!/usr/bin/env perl
# Perl weekly challenge 166
# Task 2: K-directory diff
#
# See https://wlmb.github.io/2022/05/25/PWC166/#task-2-k-directory-diff
use v5.12;
use warnings;
use autodie; # so I don't have to check for failures
use List::Util qw(uniq);

die "Usage: ./ch-2.pl a [b [c ..]]\nto compare directories a b..." unless @ARGV;
my %present;
# Prepare data
foreach(@ARGV){ # iterate over provided directories
    opendir(my $dir_handle, $_);
    while(my $file_name=readdir $dir_handle){ # iterate over directory content
        $file_name.="/" if -d "$_/$file_name"; # flag file if it is a nested directory
	$present{$file_name}{$_}=1; # $file_name is present in directory $_
    }
}
# Output results
say join "|", "", @ARGV, ""; # output row of directories
say "|-"; # separator line
foreach (sort keys %present){
    next if (keys %{$present{$_}}==uniq @ARGV); # skip files present everywhere
    print "| "; # start a row
    foreach my $directory(@ARGV){
        print $present{$_}{$directory} ? "$_ |" : " |"; # filename if present, blank if not
    }
    say "";
}
