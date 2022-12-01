#!/usr/bin/env perl
# Perl weekly challenge 193
# Task 1:  Binary String
#
# See https://wlmb.github.io/2022/11/29/PWC193/#task-1-binary-string
use v5.36;
die <<"EOF" unless @ARGV;
Usage; $0 n1 [n2...]
to print all binary numbers with n_i digits
EOF
foreach(@ARGV){
    say("Expected positive number: $_"),next unless $_>0;
    print "Binary numbers with $_ digit", $_>1?"s:":": ";
    my $i=0;
    print sprintf "%0${_}b ", $i++ while $i<2**$_;
    say "";
}
