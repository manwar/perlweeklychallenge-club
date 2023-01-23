#! /usr/bin/env raku

unit sub MAIN (UInt $int = 200, :v(:$verbose));

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

my @result;

for $int.comb -> $digit
{
  say ":Digit: $digit -> @truth[$digit]" if $verbose;

  my @matrix;

  # (^7).map({ @matrix[$_] = (" " xx 7).Array; });
  (^7).map({ @matrix[$_] = "       ".comb.Array; });

  @matrix[0] = ("-" xx 7).Array if @truth[$digit] ~~ /a/;
  @matrix[3] = ("-" xx 7).Array if @truth[$digit] ~~ /g/;
  @matrix[6] = ("-" xx 7).Array if @truth[$digit] ~~ /d/;

  @matrix[1][0] = "|" if @truth[$digit] ~~ /f/;
  @matrix[2][0] = "|" if @truth[$digit] ~~ /f/;

  @matrix[1][6] = "|" if @truth[$digit] ~~ /b/;
  @matrix[2][6] = "|" if @truth[$digit] ~~ /b/;

  @matrix[4][0] = "|" if @truth[$digit] ~~ /e/;
  @matrix[5][0] = "|" if @truth[$digit] ~~ /e/;

  @matrix[4][6] = "|" if @truth[$digit] ~~ /c/;
  @matrix[5][6] = "|" if @truth[$digit] ~~ /c/;

  (^7).map({ ": " ~ @matrix[$_].join })>>.say if $verbose;

  (^7).map({ @result[$_].push: @matrix[$_].join });
}

(^7).map({ @result[$_].join("  ") })>>.say;
