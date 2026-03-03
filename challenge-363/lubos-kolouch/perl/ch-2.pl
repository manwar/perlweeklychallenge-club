#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Perl Weekly Challenge 363 Task 2: Subnet Sheriff

=head1 SYNOPSIS

  perl ch-2.pl
  perl ch-2.pl 192.168.1.45 192.168.1.0/24

=head1 DESCRIPTION

Validates an IPv4 address and an IPv4 CIDR network, then checks whether the
address belongs to the network.

=cut

sub _parse_ipv4 ($text) {
    my @parts = split /\./, $text, -1;
    return undef if @parts != 4;

    my $ip = 0;
    for my $part (@parts) {
        return undef if $part !~ /^\d+$/;
        my $value = 0 + $part;
        return undef if $value < 0 || $value > 255;
        $ip = ( $ip << 8 ) | $value;
    }

    return $ip;
}

sub _parse_cidr ($cidr) {
    my ( $ip_text, $prefix_text ) = split m{/}, $cidr, 2;
    return undef if !defined($prefix_text) || $prefix_text !~ /^\d+$/;

    my $prefix = 0 + $prefix_text;
    return undef if $prefix < 0 || $prefix > 32;

    my $ip = _parse_ipv4($ip_text);
    return undef if !defined $ip;

    return [ $ip, $prefix ];
}

sub subnet_sheriff ( $ip_addr, $network ) {
    my $ip = _parse_ipv4($ip_addr);
    return 0 if !defined $ip;

    my $parsed = _parse_cidr($network);
    return 0 if !defined $parsed;

    my ( $network_ip, $prefix ) = @$parsed;
    my $mask = $prefix == 0 ? 0 : ( ( 0xFFFFFFFF << ( 32 - $prefix ) ) & 0xFFFFFFFF );

    return ( ( $ip & $mask ) == ( $network_ip & $mask ) ) ? 1 : 0;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::ok( subnet_sheriff( '192.168.1.45', '192.168.1.0/24' ), 'Example 1' );
    Test::More::ok( !subnet_sheriff( '10.0.0.256',  '10.0.0.0/24' ),    'Example 2' );
    Test::More::ok( subnet_sheriff( '172.16.8.9',   '172.16.8.9/32' ),  'Example 3' );
    Test::More::ok( subnet_sheriff( '172.16.4.5',   '172.16.0.0/14' ),  'Example 4' );
    Test::More::ok( subnet_sheriff( '192.0.2.0',    '192.0.2.0/25' ),   'Example 5' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <ip_addr> <network/cidr>\n" if @args != 2;
    say subnet_sheriff( $args[0], $args[1] ) ? 'true' : 'false';
}

_run_cli(@ARGV);
