use Test2::V0 -target => 'Chowla';

is $CLASS->list(20),[0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21], 'List the first 20 Chowla numbers';

is $CLASS->n(1),0, 'First Chowla number should be zero';
is $CLASS->n(2),0, 'Second Chowla number should be zero';
is $CLASS->n(3),0, 'Third Chowla number should be zero';
is $CLASS->n(4),2, 'Fourth Chowla number should be two';
is $CLASS->n(5),0, 'Fifth Chowla number should be 0';
is $CLASS->n(6),5, 'Sixth Chowla number should be 5';

done_testing;
