#!/usr/bin/perl

use strict;
use warnings;
use English;

my @args = (5, 10, 60);
my @answers;

# Sort args just for general safety-
# without_one_on_one() expects a
# sorted list
@args = sort({$a <=> $b} @args);

@answers = without_one_on_one(@args);

foreach(@args){
    printf("%4d -> %4d\n", $_, shift(@answers));
}

exit(0);



sub without_one_on_one{

    my $i = 1;
    my $num = 1;
    my @sequence = ();

    while(1){
        # Treat the number like a string
        # because we can
        if($num =~ m/^[123]+$/ && $num !~ m/11/){
            # Digit sequence matches criteria
            if($i == $ARG[0]){
                # This is the 0th member of the
                # remaining sequence- store it
                push(@sequence, $num);

                # Strip the 0th element from @ARG and
                # break the loop if @ARG is empty
                shift(@ARG);
                last unless(@ARG);
            }
            $i++; 
        } 
        $num++;
    }

    return(@sequence);

}



