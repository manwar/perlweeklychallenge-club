use strict;
use warnings;
##
# Word Search
##
my @word_grid = (
    ["B","I","D","E","M","I","A","T","S","U","C","C","O","R","S","T"],
	["L","D","E","G","G","I","W","Q","H","O","D","E","E","H","D","P"],
	["U","S","E","I","R","U","B","U","T","E","A","S","L","A","G","U"],
	["N","G","N","I","Z","I","L","A","I","C","O","S","C","N","U","D"],
	["T","G","M","I","D","S","T","S","A","R","A","R","E","I","F","G"],
	["S","R","E","N","M","D","C","H","A","S","I","V","E","E","L","I"],
	["S","C","S","H","A","E","U","E","B","R","O","A","D","M","T","E"],
	["H","W","O","V","L","P","E","D","D","L","A","I","U","L","S","S"],
	["R","Y","O","N","L","A","S","F","C","S","T","A","O","G","O","T"],
	["I","G","U","S","S","R","R","U","G","O","V","A","R","Y","O","C"],
	["N","R","G","P","A","T","N","A","N","G","I","L","A","M","O","O"],
	["E","I","H","A","C","E","I","V","I","R","U","S","E","S","E","D"],
	["S","E","T","S","U","D","T","T","G","A","R","L","I","C","N","H"],
	["H","V","R","M","X","L","W","I","U","M","S","N","S","O","T","B"],
	["A","E","A","O","F","I","L","C","H","T","O","D","C","A","E","U"],
	["Z","S","C","D","F","E","C","A","A","I","I","R","L","N","R","F"],
	["A","R","I","I","A","N","Y","U","T","O","O","O","U","T","P","F"],
	["R","S","E","C","I","S","N","A","B","O","S","C","N","E","R","A"],
	["D","R","S","M","P","C","U","U","N","E","L","T","E","S","I","L"]
);

sub get_diagonals{
    my @diagonals;
    for my $i (0..@{$word_grid[0]}){
        my @d;
        push @d, $word_grid[0]->[$i];
        my $j = 1;
        my $k = $i;
        while($j < @word_grid && $k < @{$word_grid[$j]}){
            $k++;
            push @d, $word_grid[$j]->[$k];
            $j++;
        }
        push @diagonals, \@d;
    }
    return @diagonals;
}

sub get_reverse_diagonals{
    my @reverse_grid = reverse(@word_grid);
    my @diagonals;
    for my $i (0..@{$reverse_grid[0]}){
        my @d;
        push @d, $reverse_grid[0]->[$i];
        my $j = 1;
        my $k = $i;
        while($j < @reverse_grid && $k < @{$reverse_grid[$j]}){
            $k++;
            push @d, $reverse_grid[$j]->[$k];
            $j++;
        }
        push @diagonals, \@d;
    }
    return @diagonals;
}

sub get_columns{
    my @columns;
    for my $i (0..@{$word_grid[0]}){
        $columns[$i] = [];
        for my $j (0..@word_grid){
            push @{$columns[$i]}, $word_grid[$j]->[$i];
        }
    }
    return @columns;
}

sub word_search{
    my($words, $search) = @_;
    my @found;
    for my $s (@{$search}){
        my @s = grep defined, @{$s};
        $s = join("", @s);
        for my $w (@{$words}){
            my $u = uc($w);
            my $r = reverse($u);
            push @found, lc($w) if(($s =~ m/\Q$u/ || $s =~ m/\Q$r/) && length($w) > 3);
        }
    }
    return @found;
}

MAIN:{
    my @search=(get_columns(), get_diagonals(), get_reverse_diagonals(), @word_grid);
    open(WORDS, "words");
    my $words = do{
        local $/;
        <WORDS>;
    }; 
    close(WORDS);
    my @words = split(/\n/, $words);
    my @found_words = sort {$a cmp $b} word_search(\@words, \@search);
    print "Found the following words: " . join(",", @found_words) . "\n";
}