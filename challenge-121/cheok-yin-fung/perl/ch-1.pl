say ($ARGV[0] ^ (1 << $ARGV[1]-1));

=pod
 https://en.wikipedia.org/wiki/Bitwise_operation
  #Truth_table_for_all_binary_logical_operators

p q
1 1 -> 0
1 0 -> 1
0 1 -> 1
0 0 -> 0

operation: XOR
