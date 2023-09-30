sub sell-juice (@in) {
    # %change stores the stock of bank notes. No need to
    # count $20 notes but it makes the code more generic
    my %change = '5' => 0, '10' => 0, '20' => 0;
    for @in -> $i {
        %change{$i}++;
        given $i {
            when 5 {next}
            when 10 {
                return False if %change{5} < 1;
                %change{5}--;
                next;
            }
            when 20 {
                if %change{10} > 0 and %change{5} > 0 {
                    %change{10}--; %change{5}--;
                    next;
                } elsif %change{5} >= 3 {
                    %change{5} -= 3; next;
                } else {
                    return False;
                }
            }
        }
    }
    return True;
}

my @tests = <5 5 5 10 20>, <5 5 10 10 20>, <5 5 5 20>;
for @tests -> @test {
    printf "%-15s => ", "@test[]";
    say sell-juice @test;
}
