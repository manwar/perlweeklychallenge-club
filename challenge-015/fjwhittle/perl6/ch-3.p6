#!/usr/bin/env perl6

use Cro::HTTP::Client;

sub MAIN (
  Str $phrase,
  Str :$api-key where *.chars = %*ENV<LANGDETECT_APIKEY>
) {

  my $http-client = Cro::HTTP::Client.new:
    base-uri => 'https://ws.detectlanguage.com',
    auth => { bearer => $api-key };

  my %lang = $http-client.get('/0.2/languages').result.body.result.map:
    { .<code> => (S:g/'_' +/ / given .<name>).wordcase };

  my %detect = $http-client.post(
    '/0.2/detect',
    content-type => 'application/json',
    body => {'q' =>  $phrase}
  ).result.body.result;

  my @language = %lang{%detect<data><detections>».<language>};

  say '‘%s’ is in %s'.sprintf: 
  $phrase,
  join(' and ', @language.elems > 1 ?? @language[^*.elems].join(', ') !! (), @language.tail);

  CATCH {
    when X::Cro::HTTP::Error {
      $*ERR.say: .message;
      $*ERR.say: 'During %s to ‘%s’'.sprintf: .method, .target given .request;
    }
  }
}
