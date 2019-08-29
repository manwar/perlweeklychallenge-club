#! /usr/bin/env perl

use feature 'say';
use utf8;
binmode STDOUT, ":utf8";

use LWP::Simple; 
use JSON;

my $count = 1;

$count = $ARGV[0] if @ARGV && $ARGV[0] >= 1; 

my $json = get('https://www.poemist.com/api/v1/randompoems');

my $data = from_json($json);

for (0 .. $count -1)
{
  last unless $data->[$_];
    
  my $first = '"' . $data->[$_]->{title} . '" by ' . $data->[$_]->{poet}->{name};
  say $first;  
  say '-' x length($first);    
  say $data->[$_]->{content};
  say "";
}
