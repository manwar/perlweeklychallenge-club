use strict;
use warnings;
use feature "say";

say "Please enter the name: ";
my $name = <STDIN>;
chomp $name;
my %vowels = map { $_ => 1} qw<a e i o u>;
my ($start, $suffix) = ($1, $2) if $name =~ /(\w)(\w+)/;
my @y;
if (exists $vowels{lc $start}) {
    @y = ("bo-$suffix", "fo-$suffix", "mo-$suffix");
} else {
    $y[0] = $start eq 'B' ? "bo-$suffix" : "bo-b$suffix";
    $y[1] = $start eq 'F' ? "fo-$suffix" : "fo-f$suffix";
    $y[2] = $start eq 'M' ? "mo-$suffix" : "mo-m$suffix";
}
say "\n", <<~EOF;
    $name, $name, $y[0]
    Bonana-fanna $y[1]
    Fee fi $y[2])
    $name!
    EOF
