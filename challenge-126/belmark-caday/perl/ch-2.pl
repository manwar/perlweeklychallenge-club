sub mineSweeperMatrix {
    my $matrix = shift;

    for ( my $i = 0; $i < scalar @$matrix; $i++ ) {
        for ( my $j =0; $j < scalar @{$matrix->[$i]}; $j++ ) {
            if ( $matrix->[$i]->[$j] eq '*') {
                my @loopList1 = ($i -1, $i, $i + 1);
                my @loopList2 = ($j -1, $j, $j + 1);
                my $mineCount = 0;

                foreach my $lpLst1 ( @loopList1 ) {
                    next if $lpLst1 < 0;
                    if (defined $matrix->[$lpLst1]) {
                        foreach my $lpLst2 ( @loopList2 ) {
                            next if $lpLst2 < 0;
                            next unless defined $matrix->[$lpLst1]->[$lpLst2];
                            next if $lpLst2 == $j && $lpLst1 == $i;
                            $mineCount++ if $matrix->[$lpLst1]->[$lpLst2] eq 'x';
                        }
                    }
                    else {
                        next;
                    }
                }

                print $mineCount . ", ";
            }
            else {
                print 'x, ';
            }
        }
        print "\n";
    }
}

my $testData = [
    ['x', '*', '*', '*', 'x', '*', 'x', 'x', 'x', 'x'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', 'x'],
    ['*', '*', '*', '*', 'x', '*', 'x', '*', 'x', '*'],
    ['*', '*', '*', 'x', 'x', '*', '*', '*', '*', '*'],
    ['x', '*', '*', '*', 'x', '*', '*', '*', '*', 'x']
];

mineSweeperMatrix($testData);
