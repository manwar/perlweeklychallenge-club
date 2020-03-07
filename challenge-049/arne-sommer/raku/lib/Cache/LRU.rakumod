class Cache::LRU
{
  has $.limit  is rw = 3;
  has $.verbose      = False;
  has %.lookup is rw = ();
  has $.head   is rw = Any;    # Highest
  has $.tail   is rw = Any;    # Lowest

  class LRU-elem
  {
    has $.id;
    has $.payload;
    has $.higher is rw;
    has $.lower  is rw;
  }

  method get-limit
  {
    return self.limit;
  }
    
  method set-limit (Int $new-limit)
  {
    return if $new-limit < 1;
    return if $new-limit == self.limit;

    self.limit = $new-limit;

    self.shrink while self.lookup.keys.elems > self.limit;
    
    say ": New Cache Capacity: { self.limit }" if self.verbose;
  }
  
  method shrink    # remove the last item
  {
    self.lookup{self.tail.id} :delete;
    self.tail = self.tail.higher;
    self.tail.lower = Any;
  }
  
  method !extract ($elem)
  {
    $elem.higher
      ?? ( $elem.higher.lower = $elem.lower )
      !! ( self.head = $elem.lower );

    $elem.lower
      ?? ( $elem.lower.higher = $elem.higher )
      !! ( self.tail = $elem.higher );

    $elem.higher = $elem.lower = Any;
    return $elem;
  }

  method delete ($elem)
  {
    self.lookup{$elem.id}:delete;
    return self!extract($elem);
  }
  
  method get (Int $id)
  {
    say ": get $id " if self.verbose;

    my $current = self.lookup{$id};

    return -1 unless $current;
    
    return $current.payload if $current === self.head;

    self!extract($current);
  
    self.head.higher = $current;
    $current.lower   = self.head;
    self.head        = $current;
  
    return $current.payload;
  }

  method set (Int $id, $value)
  {
    say ": set $id @ $value" if self.verbose;

    my $old-head = self.head;
  
    self.head = LRU-elem.new(id => $id, payload => $value);

    self.head.lower  = $old-head;
    $old-head.higher = self.head if $old-head;
  
    if self.lookup{$id}
    {
      self!extract(self.lookup{$id});
    }
    else   # new
    {
      self.tail = self.head unless self.tail;
      self.shrink if self.lookup.keys == self.limit;
    }
    self.lookup{$id} = self.head;
  }
  
  method dump ($elem = self.head)
  {
    print $elem.id ~ " -> " ~ $elem.payload;
    print " (head)" if $elem === self.head;
    print " (tail)" if $elem === self.tail;
    say "";
   
    self.dump($elem.lower) if $elem.lower;
  }

  method dump2 ($elem = self.head)
  {
    say $elem;
  }
}
