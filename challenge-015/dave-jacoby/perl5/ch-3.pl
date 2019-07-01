#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ say postderef signatures };
no warnings qw{ experimental::postderef experimental::signatures };
binmode STDOUT, ':utf8';

use Carp;
use JSON;
use Mojo::UserAgent;
use YAML qw{LoadFile Dump};

my $json = JSON->new->pretty->canonical;
my $mojo = Mojo::UserAgent->new;

my $config = config();
my @samples;
push @samples, 'こんにちは';
push @samples, 'This is a test';
push @samples, 'עִבְרִית‎';
push @samples, 'العربية';
push @samples, 'Buenos dias';
push @samples, 'Слава Богу, сегодня пятница';

for my $sample (@samples) {
    say $sample;
    my $out = detect_language( $config, $sample );
    for my $detection ( $out->@* ) {
        next unless $detection->{isReliable};
        my $la = $detection->{language} ;
        my $language = $config->{languages}{$la} || 'huh?';
        say "\t", $la;
        say "\t", $language;
        say "\t", $detection->{confidence};

    }
}

sub detect_language ( $config, $sample ) {
    my $url   = 'https://ws.detectlanguage.com/0.2/detect';
    my $token = $config->{key};

    # this is a form I'm going to have to rmemeber
    my $res =
        $mojo->get( 
            $url => { 'Authorization' => "Bearer $token" } 
                 => form 
                 => { q => $sample } 
            )->result;
    if ( $res->is_success ) {
        my $obj = $json->decode( $res->body );
        return $obj->{data}{detections};
    }
    elsif ( $res->is_error ) { croak $res->message }
    else                     { croak $res->message }
}

exit;

sub config () {
    # my go-to for not putting keys into github
    my $file = join '/', $ENV{HOME}, '.langdetect.yaml';
    my $config = LoadFile($file);

    # download the language CSV at https://detectlanguage.com/languages
    # it's a trivial instance, so not using Text::CSV is ... okay
    # but clearly, we don't want to try to remember that 
    # 'iw' means Hebrew if we don't have to, right?
    my $langfile = join '/', $ENV{HOME}, 'languages.csv';
    if ( -f $langfile && open my $fh , '<', $langfile ) {
        $config->{languages}->%* = 
            map { my ($la,$lang)=split m{,}, $_; $la => $lang } 
            map { chomp ; $_ } <$fh>;
    }
    return $config;
}

__DATA__

こんにちは
	ja
	Japanese
	39.04
This is a test
	en
	English
	15.01
עִבְרִית‎
	iw
	Hebrew
	1
العربية
	ar
	Arabic
	18.43
Buenos dias
	es
	Spanish
	9.38
Слава Богу, сегодня пятница
	ru
	Russian
	5.12
