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
    my $configfile = path( $ENV{HOME} // "", ".sendgrid" )->stringify();
    my ( $from, $to, $subject, $bodytext, $sandbox );
    GetOptions(
        "from=s"        => \$from,
        "to=s"          => \$to,
        "subject=s"     => \$subject,
        "body-text=s"   => \$bodytext,
        "config-file=s" => \$configfile,
    );

    die("Please provide --from")     unless defined($from);
    die("Please provide --to")       unless defined($to);
    die("Please provide --subject")  unless defined($subject);
    die("Please provide --bodytext") unless defined($bodytext);

    my $apikey = get_api_key($configfile);

    send_email(
        apikey   => $apikey,
        from     => $from,
        to       => [ split(';', $to) ],
        subject  => $subject,
        bodytext => $bodytext,
        sandbox  => $sandbox,
    );
}

sub get_api_key($configfile) {
    my (@lines) = grep { length($_) } slurp($configfile);
    die "Config-file ($configfile) must consist of one line" if @lines != 1;
    chomp $lines[0];
    return $lines[0];
}

# Usage:
# The send_email function takes a hash with the following keys:
#   apikey   = Your Sendgrid API key
#   from     = Source email address
#   to       = *ARRAY REFERENCE* of destination email addresses
#   subject  = Subject of email
#   sandbox  = True if we are using the sandbox account
#
sub send_email(%args) {
    my $url = 'https://api.sendgrid.com/v3/mail/send';

    my %json = (
        personalizations => [ { to => [] } ],
        from    => { email => $args{from} },
        subject => $args{subject},
        content => [
            {
                type  => 'text/plain',
                value => $args{bodytext},
            }
        ],
    );
    foreach my $email (sort $args{to}->@*) {
        push $json{personalizations}->[0]{to}->@*, { email => $email };
    };

    my $ua = Mojo::UserAgent->new();

    $ua->once(start => sub ($ua, $tx) {
        $tx->req->headers->header('Authorization' => "Bearer $args{apikey}");
    });

    my $tx = $ua->post($url, json => \%json);
    if ( ($tx->result->code >= 200) && ($tx->result->code <= 299) ) { return; }

    my $body = $tx->result->json;
    if (exists $body->{errors}[0]{description}) {
        die "Error from API endpoint: " . $body->{errors}[0]{description};
    } else {
        die "Error from API endpoint: " . $body->{errors}[0]{message};
    }
}

