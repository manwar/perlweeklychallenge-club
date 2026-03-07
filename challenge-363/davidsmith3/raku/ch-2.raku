#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2 Subnet Sheriff
Submitted by: Peter Campbell Smith
You are given an IPv4 address and an IPv4 network (in CIDR format).

Write a script to determine whether both are valid and the address falls within the network. For more information see the Wikipedia article.  https://en.wikipedia.org/wiki/IPv4

=CHALLENGE
=head3 Example 1:
Input: $ip_addr = "192.168.1.45"
       $domain  = "192.168.1.0/24"
Output: true

=head3 Example 2:
Input: $ip_addr = "10.0.0.256"
       $domain  = "10.0.0.0/24"
Output: false

=head3 Example 3:
Input: $ip_addr = "172.16.8.9"
       $domain  = "172.16.8.9/32"
Output: true

=head3 Example 4:
Input: $ip_addr = "172.16.4.5"
       $domain  = "172.16.0.0/14"
Output: true

=head3 Example 5:
Input: $ip_addr = "192.0.2.0"
       $domain  = "192.0.2.0/25"
Output: true

=end pod

sub get-ip(Str:D $ip -->Str) {
    my $match = $ip ~~ / ^ (\d ** 1..3) \. (\d ** 1..3) \. (\d ** 1..3) \. (\d ** 1..3) ['/'\d+]? $ /;
    return Nil if not $match;
    my $ip-bits = to-bit-string((+$0, +$1, +$2, +$3));
    return Nil if $ip-bits.chars != 32;
    $ip-bits;
}

sub get-mask(Str:D $cidr -->Str) {
    my $match = $cidr ~~ /  '/'(\d+) /;
    return Nil if not $match or not (0 <= $0 <= 32);
    1 x $0 ~ 0 x (32 - $0);
}

sub to-bit-string(List $ip -->Str) {
    [~]($ip.map(*.fmt("%08b")));
}

sub is-in(Str:D $ip, Str:D $domain, Str:D $mask -->Bool) {
    [~]($ip.comb Z+& $mask.comb) eq [~]($domain.comb Z+& $mask.comb);
}

sub my-sub(List $nums -->Bool) {
    my $ip = get-ip($nums[0])     // return False;
    my $domain = get-ip($nums[1]) // return False;
    my $mask = get-mask($nums[1]) // return False;
    is-in($ip, $domain, $mask);
}

multi MAIN(Str:D $ip, Str:D $domain) {
    say my-sub(($ip, $domain));
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub( .<input> ), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $string = rx/ \".*\" /;
    my $bool = rx/ true | false /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string) .* ($bool) / {
                @tests.push(%{ input => ($0.EVAL, $1.EVAL), output => $2.tc.EVAL });
            }
        }
    }
    @tests;
}
