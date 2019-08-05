#! /usr/bin/perl

use v5.22;

use Mojo::UserAgent;
use Mojo::URL;
use Mojo::File qw/path/;
use Mojo::Util qw/encode/;
use utf8;

#task: use the language detection api

sub api_path {
  Mojo::URL->new('https://ws.detectlanguage.com/0.2/')->path(shift)
}
say api_path('detect');

my $auth_key = path('.langdetectkey')->slurp;
chomp $auth_key;
say $auth_key;

my $headers = { Authorization => "Bearer $auth_key" };

my $ua = Mojo::UserAgent->new;

sub detect {
  $ua->post( api_path('detect'), 
    $headers, json => { q => shift } )->res->json
}

sub user_status {
  $ua->get( api_path('user/status') , $headers)->res->json
}

sub languages {
  $ua->get( api_path('languages'))->res->json
}

use Data::Printer;

my $res;
$res = detect('how are you gentlemen?');
p $res;
$res =  detect([ 'All your base are belong to us', '戦いが始まりました', 'שלום עליכם, רבותי' ]);
p $res;

$res =  user_status();
p $res;

$res =  languages();
p $res;
