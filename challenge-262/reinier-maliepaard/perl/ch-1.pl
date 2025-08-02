sub max_pos_neg {
   ( ($pos = scalar(grep { $_ > 0 } @_)) > ($neg = scalar(grep { $_ < 0} @_)) ) ? print("max positive integers: $pos\n") : print("max negative integers: $neg\n");
}

#assumption 1: no number 0
#assumption 2: number of positive and negative integers differ

@ints = qw(-3 1 2 -1 3 -2 4);
max_pos_neg(@ints); # max positive integers: 4

@ints = qw(-1 -2 -3 1);
max_pos_neg(@ints); # max negative integers: 3

@ints = qw(1 2);
max_pos_neg(@ints); # max positive integers: 2
