#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ UInt && @ints.elems > 1,
               :v(:$verbose));

my $maxpairs = @ints.maxpairs;
my $max-val  = $maxpairs[0].value;
my $max-idx  = $maxpairs[0].key;

die "Duplicate high value '$max-val'" if $maxpairs.elems > 1;

say ": Source:  @ints[]" if $verbose;
say ": - max:   $max-val" if $verbose;

@ints.splice($max-idx, 1);

my $max = @ints.max;

say ": Non-max: @ints[]" if $verbose;
say ": - max:   $max" if $verbose;

say $max-val >= $max * 2
  ?? $max-idx
  !! -1;