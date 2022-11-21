#!/usr/bin/env perl
# Perl weekly challenge 192
# Task 1:  Binary Flip
#
# See https://wlmb.github.io/2022/11/21/PWC192/#task-1-binary-flip
use v5.36;
die <<"EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to bit flip the significant digits of the integers N1, N2...
for(@ARGV){
    my $binary = sprintf "%b", $_;
    my $mask=oct "0b". "1"x length $binary;
    say "$_ -> ", ~$_ & $mask;
}
