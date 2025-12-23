#!/usr/bin/env perl
# Perl weekly challenge 353
# Task 2:  Validate Coupon
#
# See https://wlmb.github.io/2025/12/22/PWC353/#task-2-validate-coupon
use v5.36;
use feature qw(try);
use List::Util qw(zip);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 C0 N0 S0 C1 N1 S1...
    to validate coupons. Cn, Nn and Sn ares a comma separated strings
    containing codes, names and status, for the n-th list of coupons.
    FIN
for my($codes, $names, $statuses)(@ARGV){
    try {
        my @together=zip map {[split /,\s*/]} $codes, $names, $statuses;
        my @pass = map {
            my ($code, $name, $status) = $_->@*;
            die "Missing code: $codes" unless defined $code;
            die "Missing name: $names" unless defined $name;
            die "Missing status: $statuses" unless defined $status;
            $code =~ /^(\w|_)*$/                                           # valid code?
                && $name =~ /^(electronics|grocery|pharmacy|restaurant)$/i # valid name?
                && $status =~ /^true$/i                                    # valid status?
                ? "True" : "False"
        } @together;
        my $pass = join ", ", @pass;
        say "\n$codes\n$names\n$statuses\n -> $pass\n";
    }
    catch($e){ warn $e; }
}
