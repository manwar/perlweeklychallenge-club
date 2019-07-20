#!/usr/bin/env perl
#
use strict;
use warnings;
use v5.26;

my $frag=qr/[\w\d]+/;
my $qval=qr/[\w\d]+/;
my $qkey=qr/[\w\d]+/;
my $qpair=qr/$qkey\=$qval/;
my $query=qr/$qpair(?:\&$qpair)*/;
my $port=qr/\d+/;
my $path=qr/(\/(?:[\w\d\.]+\/?)+)/;
my $host=qr/[\w\d\.]+/;
my $user=qr/[\w\d]+/;
my $pass=qr/[\w\d]+/;
my $auth=qr/\/\/(?:($user)(?:\:($pass))?\@)?($host)(?:\:($port))?/;
my $scheme=qr/([a-z][a-z\-\.\+]+)/;
my $match=$ARGV[0]=~/$scheme\:$auth?$path(?:\?($query))?(?:\#($frag))?/;
die "Not a URI\n" unless $match;
my @out=( 
	"Scheme: ".($1//""),
	"User: ".($2//""),
	"Password: ".($3//""),
	"Host: ".($4//""),
	"Port: ".($5//""),
	"Path ".($6//""),
	"Query: ".($7//""),
	"Fragment: ".($8//""),
);
print join "\n", @out;
