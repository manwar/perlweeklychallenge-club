use v5.36;
use List::Util qw(max);

my $str = $ARGV[0] // die "Usage: $0 STRING\n";

my %seen;
$seen{$_}++ for split //, lc $str;

my @vowels = qw(a e i o u);
my @consonants = do {
    my %vset;
    @vset{@vowels} = ();
    grep !exists $vset{$_}, 'a' .. 'z'
};

say +(max(grep defined, @seen{@vowels}) // 0) + (max(grep defined, @seen{@consonants}) // 0);
