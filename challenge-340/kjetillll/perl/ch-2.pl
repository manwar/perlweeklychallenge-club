use List::Util 'uniq';

sub f { my @nums = pop =~ /\d+/g; "@{[ uniq sort { $a <=> $b } @nums ]}" eq "@nums" }

print f("The cat has 3 kittens 7 toys 10 beds")      == 1 ? "ok\n" : "error\n";
print f('Alice bought 5 apples 2 oranges 9 bananas') == 0 ? "ok\n" : "error\n";
print f('I ran 1 mile 2 days 3 weeks 4 months')      == 1 ? "ok\n" : "error\n";
print f('Bob has 10 cars 10 bikes')                  == 0 ? "ok\n" : "error\n";
print f('Zero is 0 one is 1 two is 2')               == 1 ? "ok\n" : "error\n";

    
