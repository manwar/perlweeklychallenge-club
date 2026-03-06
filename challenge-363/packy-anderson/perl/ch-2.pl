#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( all sum );

sub valid($val) {
  my @octets = split /\./, $val;
  if ($octets[3] =~ /\//) {
    my ($octet, $mask) = split /\//, $octets[3];
    return false if $mask > 32;
    @octets[3] = $octet;
  }
  return all { $_ <= 255 } @octets;
}

sub octets2int($ip_addr) {
  my $i = 3;
  return sum map { $_ * 2**(($i--)*8) } split /\./, $ip_addr;
}

sub in_range($ip_addr, $domain) {
  my ($prefix, $mask) = split /\//, $domain;
  my $ip_int     = octets2int($ip_addr);
  my $prefix_int = octets2int($prefix);
  my $mask_int   = (2 ** 32 - 1) ^ (2 ** (32-$mask) - 1);
  return ($ip_int & $mask_int) == $prefix_int;
}

sub subnetSheriff($ip_addr, $domain) {
  return valid($ip_addr) && valid($domain) &&
         in_range($ip_addr, $domain);
}

sub solution($ip_addr, $domain) {
  say qq/Input: \$ip_addr = "$ip_addr"/;
  say qq/       \$domain  = "$domain"/;
  say 'Output: ' . (subnetSheriff($ip_addr, $domain) ? 'true' : 'false');
}

say "Example 1:";
solution("192.168.1.45", "192.168.1.0/24");

say "\nExample 2:";
solution("10.0.0.256", "10.0.0.0/24");

say "\nExample 3:";
solution("172.16.8.9", "172.16.8.9/32");

say "\nExample 4:";
solution("172.16.4.5", "172.16.0.0/14");

say "\nExample 5:";
solution("192.0.2.0", "192.0.2.0/25");

