#!/usr/bin/env raku
use v6;

sub mutations($gene1, $gene2) {
  my $count = 0;
  my @g1 = $gene1.comb;
  my @g2 = $gene2.comb;
  for 0 .. @g1.end -> $i {
    $count++ if @g1[$i] ne @g2[$i];
  }
  $count
}

sub minimumGeneticMutation($start, $end, @bank) {
  return (0, []) if $start eq $end;
  return (-1, []) unless $end eq @bank.any;

  my @branches;
  for @bank -> $gene {
    next unless mutations($start, $gene) == 1;

    my ($count, $transitions) = minimumGeneticMutation(
      $gene, $end, @bank.grep({ $_ ne $gene })
    );
    next if $count < 0;

    $count++;
    $transitions.unshift(qq{  "$start" => "$gene"});
    @branches.push({
      count => $count, transitions => $transitions
    });
  }
  return (-1, []) unless @branches;

  my $best = @branches.min: *.{"count"};
  return ($best.{"count"}, $best.{"transitions"});
}

sub solution($start_gene, $end_gene, @gene_bank) {
  say "Input: \$start_gene = \"$start_gene\"";
  say "       \$end_gene   = \"$end_gene\"";
  my $bank = @gene_bank.map({ qq/"$_"/ }).join(', ');
  say '       @gene_bank  = (' ~ $bank ~ ')';
  my ($count, $transitions) =
    minimumGeneticMutation($start_gene, $end_gene, @gene_bank);
  say 'Output: ' ~ $count;
  if ($count > 0) {
    say "\nTransitions:";
    say $transitions.join("\n");
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
