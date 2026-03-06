#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 2: Subnet Sheriff      Submitted by: Peter Campbell Smith
You are given an IPv4 address and an IPv4 network (in CIDR format).
Write a script to determine whether both are valid and the address falls within the network. For more information see the Wikipedia article.
=end comment

my @Test =
    # ip4addr               domain                  exp
    "192.168.1.45",         "192.168.1.0/24",       True,
    "172.16.8.9",           "172.16.8.9/32",        True,
    "172.16.4.5",           "172.16.0.0/14",        True,
    "192.0.2.0",            "192.0.2.0/25",         True,
    "71.233.125.99",        "71.233.125.101/30",    False,
    "71.233.125.100",       "71.233.125.101/30",    True,
    "71.233.125.101",       "71.233.125.101/30",    True,
    "71.233.125.102",       "71.233.125.101/30",    True,
    "71.233.125.103",       "71.233.125.101/30",    True,
    "71.233.125.104",       "71.233.125.101/30",    False,
;
my @Dead = 
    "10.0.0.256",           "10.0.0.0/24",          False,
    "71.257.125.103",       "71.233.125.101/30",    False,
    "71.233.125.103",       "71.233.125.101/42",    False,
;
plan +@Test ÷ 3 + @Dead ÷ 1.5;

#  Convert a dotted quad to an Int; or False if invalid
sub quad2int( Str:D $quad -->Any:D) {
    my @octet = $quad.split( '.')».Int;
    return  False unless 4 == @octet and @octet.all ~~ ^256;    # XXX magic
    my $ret;
    for ^@octet -> \i   {   $ret += ( @octet[i] +< ((3 -i) × 8)); }
    $ret;
}

# short mask notation to Int mask; or False if invalid
sub mask2int( Int:D() $bit-count -->Any) {
    return False unless $bit-count ~~ 0..32;                    # XXX magic
    (2**$bit-count -1) × 2**(32-$bit-count);                    # XXX magic
}

# With STRICT die if any of the parts are out of bounds.
sub task( Str $address, Str $domain, Bool :$STRICT -->Bool ) {

    my ($net, $msk) = ($domain ~~ m{ ^ (.*?) '/' (\d+) $ })».Str;
    $msk.=&mask2int;
    $net.=&quad2int;
    my $adr = $address.&quad2int;
    if $STRICT and any( $msk, $net, $adr) ~~ Bool {
        die "Invalid short mask:" ~ " '$msk'"    if $msk ~~ Bool;
        die "Invalid domain:"     ~ " '$domain'" if $net ~~ Bool;
        die "Invalid address:"    ~ " '$adr'"    if $adr ~~ Bool;
    } elsif any( $msk, $net, $adr) ~~ Bool {
        return False;
    } 
    $net +&= $msk;
    $adr +& $net == $net;
}

for @Test -> $in, $domain, $exp {
    is task( $in, $domain), $exp, "{$exp // $exp.^name()} <- $in ∘∘ $domain";
}
for @Dead -> $in, $domain, $exp {
    is task( $in, $domain), $exp, "{$exp // $exp.^name()} <- $in ∘∘ $domain";
}
for @Dead -> $in, $domain, $exp {
    dies-ok { task( $in, $domain, :STRICT )},  "Dies w/ STRICT $in ∘∘  $domain";
}
done-testing;

my $ip_addr = "192.0.2.0";
my $domain  = "192.0.2.0/25";

say qq{\nInput: \$ip_addr = "$ip_addr"\n       \$domain  = "$domain"\nOutput: },
    task( $ip_addr, $domain).lc;
