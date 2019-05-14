#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use Getopt::Long;
use Mojo::Util qw(url_escape);
use Mojo::UserAgent;
use Path::Tiny;
use Perl6::Slurp;

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

MAIN: {
    my $configfile = path( $ENV{HOME} // "", ".mailgun" )->stringify();
    my ( $from, $to, $subject, $bodytext, $domain );
    GetOptions(
        "from=s"        => \$from,
        "to=s"          => \$to,
        "subject=s"     => \$subject,
        "body-text=s"   => \$bodytext,
        "config-file=s" => \$configfile,
        "domain=s"      => \$domain,
    );

    die("Please provide --from")     unless defined($from);
    die("Please provide --to")       unless defined($to);
    die("Please provide --subject")  unless defined($subject);
    die("Please provide --bodytext") unless defined($bodytext);

    my $apikey = get_api_key($configfile);
    $domain //= get_default_domain($configfile);

    send_email(
        apikey   => $apikey,
        domain   => $domain,
        from     => $from,
        to       => [ split(';', $to) ],
        subject  => $subject,
        bodytext => $bodytext
    );
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of two lines" if @lines != 2;
    chomp $lines[0];
    return $lines[0];
}

sub get_default_domain($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of two lines" if @lines != 2;
    chomp $lines[1];
    return $lines[1];
}

# Usage:
# The send_email function takes a hash with the following keys:
#   apikey   = Your Mailgun API key
#   domain   = The domain to use (configured with Mailgun)
#   from     = Source email address
#   to       = *ARRAY REFERENCE* of destination email addresses
#   subject  = Subject of email
#   bodytext = Text of email
#
sub send_email(%args) {
    my $url = 'https://api:_key_@api.mailgun.net/v3/_domain_/messages';
    my $key = url_escape($args{apikey});
    $url =~ s/_key_/$key/gs;
    $url =~ s/_domain_/$args{domain}/gs;

    my %form = (
        from    => $args{from},
        to      => $args{to},
        subject => $args{subject},
        text    => $args{bodytext},
    );

    my $ua = Mojo::UserAgent->new();
    my $tx = $ua->post($url, form => \%form);

    if ($tx->result->code == 200) { return; }

    die($tx->result->json->{message});
}

