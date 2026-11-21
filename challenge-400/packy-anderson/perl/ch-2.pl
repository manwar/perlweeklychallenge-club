#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( any min_by );

sub mutations($gene1, $gene2) {
  my $count = 0;
  my @g1 = split //, $gene1;
  my @g2 = split //, $gene2;
  for my $i ( 0 .. $#g1 ) {
    $count++ if $g1[$i] ne $g2[$i];
  }
  $count
}

sub minimumGeneticMutation($start, $end, @bank) {
  return (0, []) if $start eq $end;
  return (-1, []) unless any { $end eq $_ } @bank;

  my @branches;
  for my $gene ( @bank ) {
    next unless mutations($start, $gene) == 1;

    my ($count, $transitions) = minimumGeneticMutation(
      $gene, $end, @{[ grep { $_ ne $gene } @bank ]}
    );
    next if $count < 0;

    $count++;
    unshift @$transitions, qq{  "$start" => "$gene"};
    push @branches, {
      count => $count, transitions => $transitions
    };
  }
  return (-1, []) unless @branches;

  my $best = min_by { $_->{count} } @branches;
  return ($best->{count}, $best->{transitions});
}

sub solution($start_gene, $end_gene, $gene_bank) {
  say "Input: \$start_gene = \"$start_gene\"";
  say "       \$end_gene   = \"$end_gene\"";
  my $bank = join(', ', map { qq/"$_"/ } @$gene_bank);
  say '       @gene_bank  = (' . $bank . ')';
  my ($count, $transitions) =
    minimumGeneticMutation($start_gene, $end_gene, @$gene_bank);
  say 'Output: ' . $count;
  if ($count > 0) {
    say "\nTransitions:";
    say join("\n", @$transitions);
  }
}

say "Example 1";
solution("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]);

say "\nExample 2";
solution("AACCGGTT", "AACCGGAA", ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]);

say "\nExample 3";
solution("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]);

say "\nExample 4";
solution("GAAAAAAA", "GCCCCCCC", ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]);

say "\nExample 5";
solution("AACCGGTT", "AACCGGTT", ["AACCGGTA"]);
