use v6;

unit class PriorityQueue;

has %!queue;

method is_empty
{
  return ! %!queue.elems;
}

method insert_with_priority ($payload, Int $priority)
{
  say ":: $payload ($priority)";

  %!queue{$priority}.push: $payload;
}

method pull_highest_priority_element
{
  my $priority = %!queue.keys.max;

  # say "Q: $priority -> " ~ @(%!queue{$priority});

  my $element = @(%!queue{$priority}).shift;

  %!queue{$priority}:delete unless @(%!queue{$priority}).elems;

  return $element;
}
