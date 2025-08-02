# assumption 1: no number 0
# assumption 2: number of positive and negative integers differ, meaning
#  - positive integers > negative integers: more than (scalar(@_)/2) is positive
#  - negative integers > positive integers: less than (scalar(@_)/2) is positive

sub max_pos_neg {
   ( ($pos = scalar(grep { $_ > 0 } @_)) > (scalar(@_)/2) ) ? print("max positive integers: $pos\n") : print("max negative integers: ", (scalar(@_) - $pos) , "\n");
}

@ints = qw(-3 1 2 -1 3 -2 4);
max_pos_neg(@ints); # max positive integers: 4

@ints = qw(-1 -2 -3 1);
max_pos_neg(@ints); # max negative integers: 3

@ints = qw(1 2);
max_pos_neg(@ints); # max positive integers: 2
