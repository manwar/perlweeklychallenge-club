#! /usr/bin/perl6

class LRU {
  has Int $.size;
  has %!store;
  has @!lru;

  method set(Int $k, Int $v) {
    %!store{$k}=$v;
    self.update_lru($k);
    if @!lru.elems > $.size {
      %!store{@!lru[0]}:delete;
      @!lru.shift;
    }
  }

  method get(Int $k) {
    if %!store{$k}:exists {
      self.update_lru($k);
      return %!store{$k};
    } else {
      return -1;
    }
  }

  method update_lru(Int $k) {
    my @l=grep {$_ != $k}, @!lru;
    @l.push($k);
    @!lru=@l;
  }
}

my $q=LRU.new(size => (@*ARGS[0] or 3));
$q.set(1,3);
$q.set(2,5);
$q.set(3,7);
print $q.get(2)," = 5\n";
print $q.get(1)," = 3\n";
print $q.get(4)," = -1\n";
$q.set(4,9);
print $q.get(3)," = -1\n";
