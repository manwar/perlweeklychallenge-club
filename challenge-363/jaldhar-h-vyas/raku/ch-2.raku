#!/usr/bin/env raku

sub validIPv4(Str $ip) {
    unless $ip ~~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/ {
        return False;
    }
    
    my @octets = $ip.split('.');
    
    for @octets -> $octet {
        unless $octet ~~ 0 .. 255 {
            return False;
        }
    }
    
    return True;
}

sub validCIDR(Str $cidr) {
    unless $cidr ~~ /^(.+)\/(\d+)$/ {
        return False;
    }
    
    my ($network, $prefix) = $cidr.split('/');
    
    unless validIPv4($network) {
        return False;
    }
    
    unless $prefix ~~ 0 .. 32 {
        return False;
    }
    
    return True;
}

sub IPToInt(Str $ip) {
    my @octets = $ip.split('.');
    return (@octets[0] +< 24) + (@octets[1] +< 16) + (@octets[2] +< 8) + @octets[3];
}

sub addressInNetwork(Str $address, Str $networkcidr) {
    unless validIPv4($address) {
        return False;
    }
    
    unless validCIDR($networkcidr) {
        return False;
    }
    
    my ($network, $prefix) = $networkcidr.split('/');
    
    my $addressInt = IPToInt($address);
    my $netInt = IPToInt($network);
    
    my $mask = (0xFFFFFFFF +< (32 - $prefix)) +& 0xFFFFFFFF;
    
    return ($addressInt +& $mask) == ($netInt +& $mask);
}

sub MAIN(Str $address, Str $network) {
    say addressInNetwork($address, $network);
}
