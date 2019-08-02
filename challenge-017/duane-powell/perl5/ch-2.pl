#!/usr/bin/perl
use Modern::Perl;
use URI;

# Create a script to parse URL and print the components of URL. 
# According to Wiki page, https://en.wikipedia.org/wiki/URL
# the URL syntax is as below:
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
# For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
#
#  scheme:   jdbc:mysql
#  userinfo: user:password
#  host:     localhost
#  port:     3306
#  path:     /pwc
#  query:    profile=true
#  fragment: h1

# uri examples from https://en.wikipedia.org/wiki/Uniform_Resource_Identifier
my @uri = qw( 
https://john.doe@www.example.com:123/forum/questions/?tag=networking&order=newest#top
ldap://[2001:db8::7]/c=GB?objectClass?one
mailto:John.Doe@example.com
news:comp.infosystems.www.servers.unix
tel:+1-816-555-1212
telnet://192.0.2.16:80/
urn:oasis:names:specification:docbook:dtd:xml:4.1.2
jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
);

foreach (@uri) {
	my $uri = $_;

	# hack:
	# URI module not recognizing jdbc scheme. So if the uri 
	# matches jdbc:database:// convert to http scheme temporarily 
	my $jdbc;
	if ($uri =~ m!^(jdbc:[A-Za-z0-9]+)://!) {
		$jdbc = $1;
		$uri =~ s/$jdbc/http/;
	}

	# eval URI methods because they may not exists. See https://metacpan.org/pod/URI
	# which states "The methods available for a specific URI object depend on the scheme"
	my $u = URI->new($uri);
	my ($scheme,$userinfo,$host,$port,$path,$query,$fragment);
	eval { $scheme   = $u->scheme   }; $scheme   ||= ''; 
	eval { $userinfo = $u->userinfo }; $userinfo ||= '';
	eval { $host     = $u->host     }; $host     ||= '';
	eval { $port     = $u->port     }; $port     ||= '';
	eval { $path     = $u->path     }; $path     ||= '';
	eval { $query    = $u->query    }; $query    ||= '';
	eval { $fragment = $u->fragment }; $fragment ||= '';

	# restore uri and scheme values if we hacked them.
	if ($jdbc) {
		$scheme = $jdbc;
		$uri = $_;
	}

	my $out = <<"OUT";
uri:      $uri
scheme:   $scheme 
userinfo: $userinfo 
host:     $host
port:     $port
path:     $path
query:    $query
fragment: $fragment
OUT

	say $out;
}

__END__

./ch2.pl
uri:      https://john.doe@www.example.com:123/forum/questions/?tag=networking&order=newest#top
scheme:   https 
userinfo: john.doe
host:     www.example.com
port:     123
path:     /forum/questions/
query:    tag=networking&order=newest
fragment: top

uri:      ldap://[2001:db8::7]/c=GB?objectClass?one
scheme:   ldap 
userinfo:  
host:     2001:db8::7
port:     389
path:     /c=GB
query:    objectClass?one
fragment: 

uri:      mailto:John.Doe@example.com
scheme:   mailto 
userinfo:  
host:     
port:     
path:     John.Doe@example.com
query:    
fragment: 

...

uri:      http://user:password@localhost:3306/pwc?profile=true#h1
scheme:   jdbc:mysql 
userinfo: user:password 
host:     localhost
port:     3306
path:     /pwc
query:    profile=true
fragment: h1


