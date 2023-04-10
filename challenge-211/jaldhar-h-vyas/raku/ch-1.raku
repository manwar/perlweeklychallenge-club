#!/usr/bin/raku

sub diagonal(@matrix, $r, $c, $row, $col) {
    my $i = $row;
    my $j = $col;
    my $same = @matrix[$i;$j];

    while $i < $r && $j < $c {
        if @matrix[$i;$j] != $same {
            return False;
        }
        $i++;
        $j++;
    }
    return True;
}

sub MAIN(
    $r,
    $c,
    *@args
) {

    my @matrix = @args.batch($c);

 
    for 0 ..^ $c -> $col {
        unless diagonal(@matrix, $r, $c, 0, $col) {
            say 'false';
            exit;
        }
    }

    for 1 ..^ $r -> $row {
        unless diagonal(@matrix, $r, $c, $row, 0) {
            say 'false';
            exit;
        }
    }

   say 'true';
}