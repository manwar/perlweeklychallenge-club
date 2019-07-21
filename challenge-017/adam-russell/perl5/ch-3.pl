use strict;
use warnings;
##
# Write a script to use Bhagavad Gita API.
##
use JSON; 
use REST::Client;
use constant ACCESS_TOKEN_URL => "https://bhagavadgita.io/auth/oauth/token"; 
use constant API_URL => "https://bhagavadgita.io/api/v1/chapters/CHAPTER/verses/VERSE?access_token=ACCESS_TOKEN"; 

sub get_access_token{
    my($client) = @_;
    my $body = "client_id=<CLIENT_ID>&client_secret=<CLIENT_SECRET>&grant_type=client_credentials&scope=verse%20chapter";
    $$client->addHeader("accept", "application/json"); 
    $$client->addHeader("content-type", "application/x-www-form-urlencoded"); 
    $$client->POST(ACCESS_TOKEN_URL, $body);
    my $json = $$client->responseContent(); 
    $json = decode_json($json);
    return $json->{access_token}; 
}

sub get_sloka{
    my($client, $chapter, $verse, $access_token) = @_;
    my $url = API_URL;
    $url =~ s/CHAPTER/$chapter/; 
    $url =~ s/VERSE/$verse/; 
    $url =~ s/ACCESS_TOKEN/$access_token/; 
    $$client->addHeader("accept", "application/json"); 
    $$client->addHeader("content-type", "application/x-www-form-urlencoded"); 
    $$client->GET($url);
    my $json = $$client->responseContent(); 
    $json = decode_json($json);
    return $json->{meaning};  
}

MAIN:{
    my($chapter, $verse) = @ARGV[0 .. 1];  
    my $client = new REST::Client;
    my $access_token = get_access_token(\$client); 
    my $translation = get_sloka(\$client, $chapter, $verse, $access_token); 
    print "$translation\n"; 
}

