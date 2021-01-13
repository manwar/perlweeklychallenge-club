role LinkedList::Simple::Node
{
	has $.next is rw;

	method LinkedList
	{
		LinkedList::Simple.new( :head( self ) );
	}

	multi method append( $new-value )
	{
		self.append( $new-value but LinkedList::Simple::Node )
	}

	multi method append( LinkedList::Simple::Node $new-node )
	{
		self.next = $new-node
	}

	multi method perl()
	{
		nextsame
				}
}

role LinkedList::Simple does Iterable
{
	has LinkedList::Simple::Node $.head is rw;

	method from( *@nodes )
	{
		self.bless( :@nodes );
	}

	multi submethod BUILD( LinkedList::Simple::Node :$head, :@nodes )
	{
		$!head = my $node = $head // ( @nodes.shift but LinkedList::Simple::Node );
		$node = $node.append( $_ ) for @nodes;
	}

	method sequence()
	{
		$!head, *.next ... ! *.next.defined
	}

	method iterator()
	{
		self.sequence.iterator;
	}

	multi method perl()
	{
		"LinkedList::Simple.from({ self.sequence.map( *.perl ).join(', ') });"
	}

	method roughsort( Code $categorize )
	{
		sub dismantle( &categorize )
		{
			my $end;
			my $start;
			my $head-category = &categorize( self.head );

			gather
			{
				for self.flat -> $node
				{
					if ( $head-category == $node.&categorize )
					{
						take { :$start, :$end } with $end;

						$head-category .= not;
						$start = $node;
					}

					$end = $node;
				}

				take { :$start, :$end };
			}
		}

		sub assemble( $pieces )
		{
			my $first-node;
			my $last-frag;

			for $pieces.rotor( 2 => -1 ) -> ( $left, $right )
			{
				FIRST $first-node = $left<start>;
				LAST $last-frag = $right;

				$left<end>.next = $right<start>;
			}

			with $first-node
			{
				self.head = $first-node;
				$last-frag<end>.next = Any;
			}

			self;
		}

		assemble(
			dismantle( *.$categorize )
			.sort( not *<start>.$categorize ) );

	}
}
