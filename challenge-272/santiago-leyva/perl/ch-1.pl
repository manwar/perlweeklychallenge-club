use strict;
use warnings;
use Data::Dumper;

my $ip1 = "1.1.1.1";
my $ip2 = "255.101.1.0";

replace_ip($ip1);
replace_ip($ip2);

sub replace_ip {
my $ipx = $_[0];
print "$ipx \n";
$ipx =~ s/\./[.]/g;
print "  $ipx \n";
}