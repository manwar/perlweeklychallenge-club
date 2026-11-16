use v6;

sub dist($s1, $s2) {
    my @c1 = $s1.comb;
    my @c2 = $s2.comb;

    my $total = 0;
    for 0 .. @c1.end -> $i {
        $total++ if @c1[$i] ne @c2[$i];
    }

    return $total;
}

sub proc($s, $e, @bank) {
    say "Input: \$start = $s\n\t\$end = $e\n\t@bank = " ~ @bank;

    if $s eq $e {
	say "Output: 0";
        return 0;
    }
    
    unless $e ∈ @bank {
        say "Output: -1";
        return;
    }

    my @queue = ($s => 0);
    my %visited = ($s => 1);

    while @queue {
	my $item = @queue.shift;
        my ($gene, $steps) = ($item.key, $item.value);

        if $gene eq $e {
            say "Output: $steps";
            return $steps;
        }

        for @bank -> $next {
            next if %visited{$next};
            next unless dist($gene, $next) == 1;

            %visited{$next} = 1;
	    @queue.push($next => $steps + 1);
        }
    }

    say "Output: -1";
    return -1;
}

my $start_gene = "AACCGGTT";
my $end_gene   = "AACCGGTA";
my @gene_bank  = ("AACCGCTA", "AAACGGTA");
proc($start_gene, $end_gene, @gene_bank);

$start_gene = "AACCGGTT";
$end_gene   = "AACCGGAA";
@gene_bank  = ("AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA");
proc($start_gene, $end_gene, @gene_bank);

$start_gene = "AAAAAAAA";
$end_gene   = "AAAAACCC";
@gene_bank  = ("CAAAAAAA", "CCAAAAAA", "AAAAAAAC");
proc($start_gene, $end_gene, @gene_bank);

$start_gene = "GAAAAAAA";
$end_gene   = "GCCCCCCC";
@gene_bank  = ("GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC");
proc($start_gene, $end_gene, @gene_bank);

$start_gene = "AACCGGTT";
$end_gene   = "AACCGGTT";
@gene_bank  = ("AACCGGTA");
proc($start_gene, $end_gene, @gene_bank);
