#!/usr/bin/env kotlinc -script

// Usage:
//   kotlinc -script ./challenge-080/gugod/kotlin/ch-1.kts -- 1 2 18 4 5
//   3
//
//   ./ch-1.kts -- 7 1 2 -3 3 4 50 '-1' '-2'
//   5


val N = args.map({ it.toIntOrNull() }).filter({ it != null });
val seen = N.toSet();
val x = (1..N.size+1).first({ ! seen.contains(it) });
println(x);
