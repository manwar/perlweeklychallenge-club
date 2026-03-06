#!/usr/bin/env raku
use v6;

sub valid($val) {
  my @octets = $val.split('.');
  if (@octets[3] ~~ /\//) {
    my ($octet, $mask) = @octets[3].split('/');
    return False if $mask > 32;
    @octets[3] = $octet;
  }
  return so @octets.all <= 255;
}

sub octets2int($ip_addr) {
  my $i = 3;
  return $ip_addr.split('.').map({ $_ * 2**(($i--)*8)}).sum;
}

sub in_range($ip_addr, $domain) {
  my ($prefix, $mask) = $domain.split('/');
  my $ip_int     = octets2int($ip_addr);
  my $prefix_int = octets2int($prefix);
  my $mask_int   = (2 ** 32 - 1) +^ (2 ** (32-$mask) - 1);
  return ($ip_int +& $mask_int) == $prefix_int;
}

sub subnetSheriff($ip_addr, $domain) {
  return valid($ip_addr) && valid($domain) &&
         in_range($ip_addr, $domain);
}

sub solution($ip_addr, $domain) {
  say qq/Input: \$ip_addr = "$ip_addr"/;
  say qq/       \$domain  = "$domain"/;
  say 'Output: ' ~ subnetSheriff($ip_addr, $domain);
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
