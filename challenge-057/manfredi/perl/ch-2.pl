#!/usr/bin/env perl
use strict;
use warnings;

sub count($$) {
    my ($instr, $sub) = @_;
    my $pos = 0;
    my $cnt = 0;
    while ( ($pos = index($instr, $sub, $pos) ) > -1 ) {
        $pos++;
        $cnt++;
    }
    $cnt;
}

my %abbr = ();
my $input = [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ];
# my $input = [ "alphabet", "car", "carboxy", "book", "carpet", "cadmium", "cadeau", "alpine" ];

# for cases when a starting substring is inside of another string
my $instr = ':' . join ':', sort @{$input};

my $max = (sort map { length $_ } @{$input})[-1];

for my $length (1..$max) {

    for my $word (@$input) {
        next if defined $abbr{$word};

        # for cases when $word_a is a starting substring of $word_b, eg. car carpet
        $abbr{$word} = $word and next if length($word) == $length;

        my $sub = ':' . substr($word, 0, $length);
        
        #my $found = () = $instr =~ /$sub/g; # benchmark: slower than "index" version
        my $found = count($instr, $sub);     # benchmark: about double faster then "regexp" version
        
        if ($found == 1) {
            $sub =~ tr/://d;
            $abbr{$word} = $sub;
        }
    }
}

my $in  = join ', ',  map { '"'.$_.'"' }        @{$input};
my $out = join ', ',  map { '"'.$abbr{$_}.'"' } @{$input};

print "Input  [ $in ]\n";
print "Output [ $out ]\n";

__END__
$ ./ch-2.pl
Input  [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
Output [ "alph", "b", "car", "cadm", "cade", "alpi" ]
