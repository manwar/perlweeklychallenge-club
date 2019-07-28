################################################################################
=begin comment

Perl Weekly Challenge 018
=========================

Task #2
-------
Write a script to implement *Priority Queue*. It is like regular *queue* except
each element has a *priority* associated with it. In a priority queue, an
element with high priority is served before an element with low priority. Please
check this [ https://en.wikipedia.org/wiki/Priority_queue |wiki page] for more
informations. It should serve the following operations:

  1) *is_empty*: check whether the queue has no elements.

  2) *insert_with_priority*: add an element to the queue with an associated
      priority.

  3) *pull_highest_priority_element*: remove the element from the queue that has
      the highest priority, and return it. If two elements have the same
      priority, then return element added first.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

class MyPriorityQueue
{
    use Heap;

    has Heap $!heap;

    submethod BUILD(Bool :$reverse = False)
    {
        $!heap = $reverse ?? Heap[-*<order>].new
                          !! Heap[ *<order>].new;
    }

    method is_empty(--> Bool)
    {
        return !?$!heap;
    }

    method insert_with_priority(Int:D $priority, Any:D $element)
    {
        $!heap.push: { order => $priority,
                       datum => $element, };
    }

    method pull_highest_priority_element(--> Any)
    {
        my Any $element;

        unless self.is_empty()
        {
            my %top = $!heap.pop;

            $element = %top< datum >;
        }

        return $element;
    }
}

################################################################################
