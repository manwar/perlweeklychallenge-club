#! /usr/bin/env raku

subset GENESTRING where * ~~ /^ <[ACGT]> ** 8 $/;

unit sub MAIN (GENESTRING $start,
               GENESTRING $end,
               *@bank where @bank.elems > 0 && all(@bank) ~~ GENESTRING);

if $start eq $end
{
  say 0;
  exit;
}

my %bank = @bank.Bag;

unless %bank{$end}
{
  say -1;
  exit;
}

my @queue      = $start;
my %seen       = $start => 1;
my $steps = 0;

while @queue
{
  $steps++;
  my @next;

  for @queue -> $gene
  {
    for $gene.comb.kv -> $i, $orig
    {
      for <A C G T> -> $c
      {
        next if $c eq $orig;
        my $mut = $gene.substr(0, $i) ~ $c ~ $gene.substr($i + 1);
        next unless %bank{$mut} && !%seen{$mut};

        if $mut eq $end
        {
          say $steps;
          exit;
        }

        %seen{$mut} = 1;
        @next.push: $mut;
      }
    }
  }

  @queue = @next;
}

say -1;