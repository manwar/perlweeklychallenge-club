# The Weekly Challenge 184
# Task 1 Sequence Number
use v5.30.0;
use warnings;


sub two_digits {
    return $_[0] if length $_[0] == 2;
    return "0".$_[0] if length $_[0] == 1;
}

sub seq_num {
    my @list = $_[0]->@*;
    my @new_list;
    my $k = 0;
    for (@list) {
        my $dd = two_digits($k);
        $_ =~ s/[a-z]{2}/$dd/;
        push @new_list, $_;
        $k++;
    }

    return [@new_list];
}



use Test::More;
use Test::Deep;

cmp_deeply(seq_num(['ab1234', 'cd5678', 'ef1342']), 
           ['001234', '015678', '021342']);
cmp_deeply(seq_num(['pq1122', 'rs3334']), 
           ['001122', '013334']);
done_testing();
