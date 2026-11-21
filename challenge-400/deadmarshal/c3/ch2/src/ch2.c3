module ch2;

import std::io;
import std::collections;
import std::core::mem::alloc;

alias GeneSet = HashSet{String};
alias DistMap = HashMap{String,int};
alias GeneQueue = List{String};

const String LETTERS = "ACGT";

fn int? minimum_genetic_mutation(Allocator allocator,
				 String start,
				 String end,
				 String[] bank)
{
  if(start == end) return 0;

  GeneSet valid;
  valid.init(allocator);
  defer valid.free();
  foreach(g : bank) valid.add(g);
  if(!valid.contains(end)) return -1;

  DistMap seen;
  seen.init(allocator);
  defer seen.free();
  seen.set(start,0);

  GeneQueue queue;
  queue.init(allocator);
  defer queue.free();

  queue.push(start);
  sz head = 0;

  while(head < queue.len())
  {
    String gene = queue[head++];
    int steps = seen.get(gene)!;

    for(sz i = 0; i < gene.len; i++)
    {
      foreach(c : LETTERS)
      {
	if(gene[i] == c) continue;
	String next = gene.tcopy();
	next[i] = c;
	if(!valid.contains(next)) continue;
	if(seen.has_key(next)) continue;

	if(next == end) return steps+1;
	seen.set(next,steps+1);
	queue.push(next);
      }
    }
  }
  return -1;
}

