#!/usr/bin/env kotlinc -script

// Usage:
//
//     # kotlinc -script ./challenge-080/gugod/kotlin/ch-2.kts 1 4 3 2
//     7

val N = args.map({ it.toIntOrNull() }).filter({ it != null });

val extra = (1..N.lastIndex).filter({ N[it] != N[it-1] }).size;

println( N.size + extra );
