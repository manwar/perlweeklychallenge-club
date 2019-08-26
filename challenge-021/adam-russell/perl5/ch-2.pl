use strict;
use warnings;
##
# Write a script for URL normalization based on rfc3986.
##    
use UrlParser;
use constant URL => q|JDBC://user:password@localhost:3306/pwc?profile=true#h1|; 
MAIN:{
    my $parser = new UrlParser();
    $parser->parse(URL);
}  

__DATA__ 
use constant URL => "HTTP://www.example.com:80/a%C2%B1b/%7Eusername"; 
