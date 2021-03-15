$_ % 3 == 0  ? ($_ % 5 == 0 ? print 'fizzbuzz' : print 'fizz') : ($_ % 5 == 0 ? print 'buzz' : print $_) foreach(1..20);

