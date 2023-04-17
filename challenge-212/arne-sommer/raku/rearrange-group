#! /usr/bin/env raku

multi MAIN (UInt $size where $size >= 1, *@list where @list.elems >= 2 && @list.all ~~ Int && @list.elems %% $size, :v(:$verbose))
{
  say ": size: $size" if $verbose;

  my @sorted = @list>>.Int.sort;

  say ": Sorted source: @sorted[]" if $verbose;
  
  my @res;
  
  for 1 .. @list.elems / $size -> $group
  {
    my @group = @sorted.shift;

    say ": New group $group starting with @group[0]" if $verbose;
    
    while @group.elems < $size
    {
      my $target = @group.tail + 1;
      my $index  = @sorted.first($target, :k);
      
      if defined $index
      {
        say ": Found target $target at index $index" if $verbose;
	
        @group.append: @sorted.splice($index,1);  # as splice gives a list, and push would gladly add that.

        say ": Group now: @group[] (Rest: @sorted[])" if $verbose;
      }
      else
      {
        say ": Did not find target $target" if $verbose;
        say '-1';
	exit;
      }
    }

    @res.push: @group;
    say ": Added group to result: @group[]" if $verbose;
  }

  say @res>>.join(",").map({ "($_)" }).join(", ");
}

multi MAIN (*@slurp, :v(:$verbose))
{
  say '-1';
}
