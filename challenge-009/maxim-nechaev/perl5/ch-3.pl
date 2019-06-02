#!/usr/bin/perl -w
use strict;
use utf8;
use Encode;
use Email::Sender::Transport::SMTP;
use Email::Sender::Simple qw/sendmail/;
use MIME::Entity;

my $SparkpostAPIKey = '3d349e3c7f7c309a6b2be80bca6f4f9e0c7d1621';
my $toEmail         = 'maxim@nechaev.net';
my $fromEmail       = 'sparkpost@nechaev.net';

# docs https://developers.sparkpost.com/api/smtp/
my $sparkpost = Email::Sender::Transport::SMTP->new({
    host          => 'smtp.sparkpostmail.com',
    port          => 587,
    ssl           => 'starttls',
    sasl_username => 'SMTP_Injection',
    sasl_password => $SparkpostAPIKey,
});

my $email = MIME::Entity->build(
    Type     => 'text/plain',
    Encoding => 'quoted-printable',
    Charset  => 'UTF-8',
    To       => encode('MIME-Header', 'Perl Hacker') . " <$toEmail>",
    From     => encode('MIME-Header', 'Sparkpost'  ) . " <$fromEmail>",
    Subject  => encode('MIME-Header', 'Email through Sparkpost'),
    Data     => 'This email from perl script using Sparkpost API',
    #'X-MSYS-API' => '{"options": { "sandbox" : true }}',
);

sendmail( $email, { transport => $sparkpost } );
