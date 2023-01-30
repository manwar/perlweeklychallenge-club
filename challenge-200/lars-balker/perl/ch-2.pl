use v5.30;

my @array = (1,2,3,4);
# Output: (1,2,3), (2,3,4), (1,2,3,4)

my @res;
for my $length (3 .. @array) {
  I:
    for my $i (0 .. @array - $length) {
        my $delta = $array[$i + 1] - $array[$i];
        my $j = 1;
        while ($j + 1 < $length) {
            next I if $array[$i + $j + 1] - $array[$i + $j] != $delta;
            $j++;
        }
        push @res, [ @array[ $i .. $i + $length - 1 ] ];
    }
}
@res = ([]) unless @res;
say join ", ", map { "(" . (join ",", @$_) . ")" } @res;




my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg a cdefg abc abcdefg abcfg>;

my @input = split //, "200";

my @out = ("aaaaaaa  ",
           "f     b  ",
           "f     b  ",
           "ggggggg  ",
           "e     c  ",
           "e     c  ",
           "ddddddd  ");
my %symbol = qw/ a -  b |  c |  d -  e |  f |  g - /;

for my $line (0..$#out) {
    for my $digit (@input) {
        my @show = split //, $truth[$digit];
        my $out  = $out[$line];
        $out =~ s/$_/$symbol{$_}/g for @show;
        $out =~ s/[a-g]/ /g;
        print $out;
    }
    print "\n";
}
