#!/usr/bin/raku

sub MAIN(
    $start_gene,
    $end_gene,
    *@gene_bank
) {
    if $start_gene eq $end_gene {
        say 0;
        return;
    }

    my Set $bank = @gene_bank;

    unless $end_gene ∈ $bank {
        say -1;
        return;
    }

    my %distance = $start_gene => 0;
    my @queue = $start_gene;
    my $head = 0;

    while $head < @queue.elems {
        my $currentGene = @queue[$head++];
        my @characters = $currentGene.comb;

        for 0 .. @characters.end -> $position {
            my $originalBase = @characters[$position];

            for <A C G T> -> $nextBase {
                if $nextBase eq $originalBase {
                    next;
                }

                @characters[$position] = $nextBase;
                my $nextGene = @characters.join(q{});
                @characters[$position] = $originalBase;

                unless $nextGene ∈ $bank {
                    next;
                }

                if %distance{$nextGene}:exists {
                    next;
                }

                %distance{$nextGene} = %distance{$currentGene} + 1;

                if $nextGene eq $end_gene {
                    say %distance{$nextGene};
                    return;
                }

                @queue.push($nextGene);
            }
        }
    }

    say -1;
}
