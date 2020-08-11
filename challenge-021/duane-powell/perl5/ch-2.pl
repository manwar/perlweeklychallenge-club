#!/usr/bin/perl
use Modern::Perl;
use URI qw(canonical);

# take a list of urls and say their normal forms

my @url = qw(
HTTP://www.Example.com/
HTTP://www.example.COM:80/
https://www.example.com/
https://www.example.com:443/
http://www.example.com/a%c2%b1b
http://www.example.com/%7Eusername/
http://www.example.com:80/bar.html
);

my %normal_url;
foreach my $url (@url) {
	push @{ $normal_url{ URI->new($url)->canonical() } }, $url;
}

foreach my $url ( sort {$a cmp $b} (keys %normal_url) ) {
	say $url;
	foreach ( sort {$a cmp $b} @{ $normal_url{$url} } ) {
		say "\t$_";
	}
}

__END__

./ch2.pl
http://www.example.com/
        HTTP://www.Example.com/
        http://www.example.com:80/
http://www.example.com/a%C2%B1b
        http://www.example.com/a%c2%b1b
http://www.example.com/bar.html
        http://www.example.com:80/bar.html
http://www.example.com/~username/
        http://www.example.com/%7Eusername/

