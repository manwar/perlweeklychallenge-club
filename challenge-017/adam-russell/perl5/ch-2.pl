use strict;
use warnings;
##
# Create a script to parse URL and print the components of URL.
##
use UrlParser;
use constant URL => q|jdbc://user:password@localhost:3306/pwc?profile=true#h1|; 

MAIN:{
    my $parser = new UrlParser();
    $parser->parse(URL);
}  
