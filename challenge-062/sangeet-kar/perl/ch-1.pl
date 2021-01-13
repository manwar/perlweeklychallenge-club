use strict;
use warnings;

use Getopt::Std;

my %opts;
getopts( 'u', \%opts );

my @mails;
my %db;

while (<>) {
    chomp;
    my ( $name, $domain ) = split /@/;
    if ( $opts{u} ) {
        if ( not exists $db{ $name . lc($domain) } ) {
            push @mails, [ $name, $domain ];
            $db{ $name . lc($domain) }++;
        }
    }
    else {
        push @mails, [ $name, $domain ];
    }
}

my @sorted = sort { lc( @$a[1] ) . @$a[0] cmp lc( @$b[1] ) . @$b[0] } @mails;
print join "\n", ( map { join "@", @$_ } @sorted );
