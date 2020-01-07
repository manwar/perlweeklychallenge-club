use strict;
use warnings;

my @chars  = ('(', ')');
my $lenght; 
my $rands;
my $countr;
my $countl;

$lenght = int(rand(15)) + 1;
while ($lenght--){ $rands.= $chars[rand @chars] };
print "$rands";
$countr = () = $rands =~ /\(/g;
$countl = () = $rands =~ /\)/g;
if ($countr - $countl == 0) {
    print " - OK\n";
    } else {
    print " - NOT OK\n";
    }