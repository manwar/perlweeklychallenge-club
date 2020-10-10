use v6.d;

my $regex := rx/ :r              # Don't backtrack
    <!after <:L>｢'｣>             # Don't match if preceded by word + ｢'｣
                                 # (avoids matching ｢s｣ in ｢word's｣)
    <:L>+ [｢-｣<:L>+]*            # Match dash-separated words
    [｢'｣<!before ｢s｣<ws>><:L>+]? # It may end with ｢'｣ + word (except for ｢'s｣)
/;

my @words := ('input'.IO.slurp ~~ m:g/$regex/)>>.Str;
my %score := ({}, |@words).reduce: { %^score{$^word}++; %^score }
my $add   := { %^data{$^pair.value}.push: $^pair.key; %^data }
my %data  := ({}, |%score.pairs).reduce: $add;

printf "%s %s\n\n", .key, .value.sort.join: ｢ ｣ for sort %data.pairs;
