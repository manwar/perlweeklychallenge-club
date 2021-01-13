#! /usr/bin/env raku

subset PosInt of Int where * >= 1;

unit sub MAIN (PosInt $N, :$v, :$verbose = :$v);

class LinkedElement
{
  has $.value is rw;
  has $.next  is rw;

  method print-list
  {
    print self.value;
    if self.next
    {
      print " -> ";
      self.next.print-list;
    }
    else
    {
      print "\n";
    }
  }

  method list-length
  {
    my $length = 1;

    my $current = self.next;

    while ($current)
    {
      $current = $current.next;
      $length++;
    }
    return $length;
  }

  method remove-from-end($from-the-end)
  {
    my $length = self.list-length;

    if $length == 1
    {
       die "[]";
    }
    elsif $from-the-end > $length
    {
      self.value = self.next.value;
      self.next  = self.next.next;
    }
    else
    {
      my $current = self;

      for 1 .. ($length - $from-the-end -1)
      {
        $current = $current.next;
      }
    
      $current.next = $current.next.next;
    }
  }
}

my $length = (1..50).pick;

my $head;
my $current;

for 1..$length -> $value
{
  my $new = LinkedElement.new(value => $value);

  if $current
  {
    $current.next = $new;
    $current = $current.next;
  }
  else # Initially
  {
    $head = $new;
    $current = $head;
  }
}

$head.print-list;

say "Length: ", $head.list-length if $verbose;

$head.remove-from-end($N);

$head.print-list;
