use v5.38;

sub loadup($i, $j, $height, $width, @chars) {
    my ($n, $e, $s, $w) = ('_', '_', '_', '_');
    if ($i - 1 >= 0) {
        $n = ${$chars[$i - 1]}[$j];
    }
    if ($i + 1 < $height) {
        $s = ${$chars[$i + 1]}[$j];
    }
    if ($j - 1 >= 0) {
        $w = ${$chars[$i]}[$j - 1];
    }
    if ($j + 1 < $width) {
        $e = ${$chars[$i]}[$j + 1];
    }
    return ($n, $e, $s, $w);
}

sub findit($i, $j, $height, $width, $str, $visited, @chars) {
    my $step = scalar keys %$visited;
    return 1 if $step == length $str;
    
    my $letter = substr($str, $step, 1);
    my %h;
    ($h{n}, $h{e}, $h{s}, $h{w}) = loadup($i, $j, $height, $width, @chars);

    for my $dir (keys %h) {
        next if $h{$dir} eq "_" || $h{$dir} ne $letter;

        my ($ni, $nj) = ($i, $j);
        $ni-- if $dir eq 'n';
        $ni++ if $dir eq 's';
        $nj-- if $dir eq 'w';
        $nj++ if $dir eq 'e';

        # Skip previously visited cells
        my $key = "$ni,$nj";
        next if $visited->{$key};

        $visited->{$key} = 1;
        return 1 if findit($ni, $nj, $height, $width, $str, $visited, @chars);
        delete $visited->{$key};
    }
    return 0;
}

sub proc($str, @chars) {
    say "Input: \n \@chars = ";
    for (@chars) {
        say "\t@$_";
    }
    say " \$str = $str";
    my $height = @chars;
    my $width = @{$chars[0]};
    my $veracity = 0;

    for my $i (0 .. $height - 1) {
        for my $j (0 .. $width - 1) {
            if (${$chars[$i]}[$j] eq substr($str, 0, 1)) {
                my %visited = ("$i,$j" => 1);
                $veracity = findit($i, $j, $height, $width, $str, \%visited, @chars);
            }
            last if $veracity;
        }
        last if $veracity;
    }
    say "\nOutput: ", $veracity ? "True\n" : "False\n";
}

my @chars = (['A', 'B', 'D', 'E'],
             ['C', 'B', 'C', 'A'],
             ['B', 'A', 'A', 'D'],
             ['D', 'B', 'B', 'C']);
my $str = "BDCA";
proc($str, @chars);

@chars = (['A', 'A', 'B', 'B'],
          ['C', 'C', 'B', 'A'],
          ['C', 'A', 'A', 'A'],
          ['B', 'B', 'B', 'B']);
$str = "ABAC";
proc($str, @chars);

@chars = (['B', 'A', 'B', 'A'],
          ['C', 'C', 'C', 'C'],
          ['A', 'B', 'A', 'B'],
          ['B', 'B', 'A', 'A']);
$str = "CCCAA";
proc($str, @chars);
