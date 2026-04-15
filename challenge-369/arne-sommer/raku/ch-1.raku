#! /usr/bin/env raku

unit sub MAIN ($caption where $caption.chars > 0,
               :v(:$verbose));

my $stripped = $caption.comb.grep({ /<[a..z A..Z \s]>/ }).join;
my @words    = $stripped.words;
my $final    = "#" ~ @words.shift.lc ~ @words.map({ .tclc }).join;

say ": English & Spaces: «$stripped»\n: Final: «$final»" if $verbose;

say $final.chars > 100 ?? $final.substr(0, 100) !! $final;



