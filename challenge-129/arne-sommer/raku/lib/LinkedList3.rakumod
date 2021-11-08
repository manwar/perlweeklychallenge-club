class LinkedList3
{
  has Int         $.value;
  has LinkedList3 $.next is rw;

  method from-string ($string, :z(:$zero))
  {
    die "Do not call on an object" if self ~~ LinkedList3:D;

    my @values = $string.comb.grep({ /\S/ });

    _validate(@values, :$zero);

    return LinkedList3.add-elems(@values>>.Int, :$zero);
  }

  method add-elems (@values, :r(:$replace-next), :z(:$zero))
  {
    _validate(@values, :$zero);

    my $list  = self;
    my $first = @values[0];
    my $obj   = LinkedList3.new(value => $first);

    if $list ~~ LinkedList3:D
    {
      unless $replace-next { $list = $list.next while $list.next; }
      $list.next = $obj;
    }
    else
    {
      $list = $obj;
    }

    $obj.add-elems(@values[1 .. *-1], :$zero) if @values.elems > 1;

    return $obj;
  }

  method recursive-value
  {
    return flat(self.value, self.next.recursive-value) if self.next;
    return self.value;
  }

  method nice (Str $sep = ' => ')
  {
    return self.recursive-value.join($sep);
  }

  method sum (LinkedList3 $l1, LinkedList3 $l2)
  {
    die "Do not call on an object" if self ~~ LinkedList3:D;
    
    return LinkedList3.from-string( ( $l1.nice("") + $l2.nice("") ), :zero );
  }

  sub _validate(@values, :z(:$zero))
  {
    $zero
      ?? ( die "Must be 0..9 only" unless all(@values) ~~ /^<[0..9]>$/ )
      !! ( die "Must be 1..9 only" unless all(@values) ~~ /^<[1..9]>$/ );

    return True;
  }
}
