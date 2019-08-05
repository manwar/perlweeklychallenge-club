#!/bin/env perl

use Modern::Perl;
use WWW::Mechanize;
use XML::LibXML;

exit unless @ARGV;

my $m = WWW::Mechanize->new() or die "cannot initialize robot\n";

my $base_url = 'http://www.stands4.com/services/v2/syno.php?uid=7082&tokenid=Bnm2q0xAKY2up6qQ';
my $url = $base_url . "&word=$ARGV[0]&format=xml";

$m->get($url);

my $dom = XML::LibXML->load_xml(string => $m->content);
foreach my $r ($dom->findnodes('//result')) {
    say 'term:       ', $r->findvalue('./term');
    say '  definition:   ', $r->findvalue('./definition');
    say '  example:      ', $r->findvalue('./example');
    say '  partofspeech: ', $r->findvalue('./partofspeech');
    say '  synonyms:     ', $r->findvalue('./synonyms');
    say '  antonyms:     ', $r->findvalue('./antonyms');
}
