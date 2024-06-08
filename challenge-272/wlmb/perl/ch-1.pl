#!/usr/bin/env perl
# Perl weekly challenge 272
# Task 1:  Defang IP Address
#
# See https://wlmb.github.io/2024/06/03/PWC272/#task-1-defang-ip-address
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 A1 A2...
    to defang the IP addresses A1 A2...
    FIN
my $ip=join '\.', ('\d{1,3}') x 4;
for(@ARGV){
    my $original=$_;
    warn "Not a valid IP: $_", next unless /^$ip$/;
    s/\./[.]/g;
    say "$original -> $_";
}
