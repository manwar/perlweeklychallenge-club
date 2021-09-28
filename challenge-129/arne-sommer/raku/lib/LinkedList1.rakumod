class LinkedList1
{
  has Int         $.value;
  has LinkedList1 $.next is rw;
  
  method add-elems (@values, :r(:$replace-next))
  {
    my $list  = self;
    my $first = @values[0];
    my $obj   = LinkedList1.new(value => $first);

    if $list ~~ LinkedList1:D
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
}
