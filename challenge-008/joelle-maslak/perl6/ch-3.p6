#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

use Cro::HTTP::Client;

sub MAIN(
    Str:D :$from,
    Str:D :$to,
    Str:D :$subject,
    Str:D :$body-text,
    Str:D :$config-file? = $*HOME.add(".mailgun").Str,
    Str   :$domain? is copy,
) {
    my $api-key   = get-api-key($config-file);
    $domain     //= get-default-domain($config-file);

    send-email(:$api-key, :$domain, :$from, :to($to.split(';')), :$subject, :$body-text);
}

sub get-api-key(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines[0];
}

sub get-default-domain(Str:D $config-file -->Str:D) {
    my @lines = $config-file.IO.lines().grep( *.chars > 0 );
    die "Config-file ($config-file) must consist of two lines" if @lines.elems ≠ 2;

    return @lines[1];
}

# Usage:
#   $api-key   = Your Mailgun API key
#   $domain    = The domain to use (configured with Mailgun)
#   $from      = Source email address
#   @to        = Array of destination email addresses
#   $subject   = Subject of email
#   $body-text = Text of email
#
sub send-email(
    Str:D :$api-key,
    Str:D :$domain,
    Str:D :$from,
          :@to,
    Str:D :$subject,
    Str:D :$body-text,
) {
    my $url = "https://api.mailgun.net/v3/$domain/";

    my @body;
    @body.push: Pair.new('from',    $from);
    @body.push: Pair.new('subject', $subject);
    @body.push: Pair.new('text',    $body-text);

    for @to.unique -> $to {
        @body.push: Pair.new('to', $to);
    }

    my $client = Cro::HTTP::Client.new(
        base-uri => $url,
        auth     => {
            username => 'api',
            password => $api-key,
        },
    );
    my $resp = await $client.post('messages',
                                  content-type => 'application/x-www-form-urlencoded',
                                  body => @body);
    if $resp.status == 200 { return }

    CATCH {
        when X::Cro::HTTP::Error {
            my $body = await .response.body;
            die "Error from API endpoint: $body<message>";
        }
    }
}

