module ch2_test;

import ch2;

fn void minimum_genetic_mutation_test() @test
{
  test::eq(-1,
	   ch2::minimum_genetic_mutation(tmem,
					 "AACCGGTT",
					 "AACCGGTA",
					 {"AACCGCTA","AAACGGTA"})!!);
  
  test::eq(2,
	   ch2::minimum_genetic_mutation(tmem,
					 "AACCGGTT",
					 "AACCGGAA",
					 {"AACCGGTA",
					   "AACCGGAA",
					   "AACCGCTA",
					   "AACCCTAA",
					   "AACCGTAA"})!!);
  
  test::eq(-1,
	   ch2::minimum_genetic_mutation(tmem,
					 "AAAAAAAA",
					 "AAAAACCC",
					 {"CAAAAAAA",
					   "CCAAAAAA",
					   "AAAAAAAC"})!!);
  
  test::eq(7,
	   ch2::minimum_genetic_mutation(tmem,
					 "GAAAAAAA",
					 "GCCCCCCC",
					 {"GCAAAAAA",
					   "GCCAAAAA",
					   "GCCCAAAA",
					   "GCCCCAAA",
					   "GCCCCCAA",
					   "GCCCCCCA",
					   "GCCCCCCC"})!!);
  
  test::eq(0,
	   ch2::minimum_genetic_mutation(tmem,
					 "AACCGGTT",
					 "AACCGGTT",
					 {"AACCGGTA"})!!);
}

