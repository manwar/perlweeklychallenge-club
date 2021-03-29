use v6;

my $name = prompt "Please enter the name: ";
my $vowels = Set.new(<a e i o u>);
my $consonants = Set.new('a'..'z') (-) $vowels;
my ($start, $suffix) = ($0, $1) if $name ~~ /(\w)(\w+)/;

my @y;
if $start.lc (elem) $consonants {
    @y[0] = $start eq 'B' ?? "bo-$suffix" !! "bo-b$suffix";
    @y[1] = $start eq 'F' ?? "fo-$suffix" !! "fo-f$suffix";
    @y[2] = $start eq 'M' ?? "mo-$suffix" !! "mo-m$suffix";
} else {
    @y = "bo-$suffix", "fo-$suffix", "mo-$suffix";
}

say qq:to/END/;
    $name, $name, @y[0]
    Bonana-fanna @y[1]
    Fee fi @y[2])
    $name!
    END
