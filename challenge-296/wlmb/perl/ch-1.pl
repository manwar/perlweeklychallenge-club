#!/usr/bin/env perl
# Perl weekly challenge 296
# Task 1:  String Compression
#
# See https://wlmb.github.io/2024/11/18/PWC296/#task-1-string-compression
use v5.36;
die <<~"FIN" unless @ARGV and (my $name=lc shift)=~/compress|decompress/;
    Usage: $0 C S1 S2...
    to compress or decompress the strings S1 S2
    using run length encoding according to the command C, compress or decompress.
    FIN
my %commands=(
    compress=>sub($x){
	$x=~/\d/&& warn "Digit found $x"; $x=~s/(.)(\1+)/$1.(1+length $2)/ge;return $x;},
    decompress=>sub($x){$x=~s/(.)(\d+)/"$1" x $2/ge; return $x}
    );
my $command=$commands{$name};
for(@ARGV){
    say "$_ -> ", $command->($_);
}
