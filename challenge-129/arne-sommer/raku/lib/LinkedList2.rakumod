class LinkedList2
{
  has Int        $.value;
  has LinkedList2 $.next is rw;
  
  method add-elems (@values, :r(:$replace-next))
  {
    my $list  = self;
    my $first = @values[0];
    my $obj   = LinkedList2.new(value => $first);

    if $list ~~ LinkedList2:D
    {
      unless $replace-next { $list = $list.next while $list.next; }
      $list.next = $obj;
    }
    else
    {
      $list = $obj;
    }

    $obj.add-elems(@values[1 .. *-1]) if @values.elems > 1;

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

  method sum (LinkedList2 $l1, LinkedList2 $l2)
  {
    die "Do not call on an object" if self ~~ LinkedList2:D;
    
    return LinkedList2.add-elems( ( $l1.nice("") + $l2.nice("") ).comb>>.Int );
  }
}
