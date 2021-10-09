package main

/*
Write a script to implement Hash Join algorithm as suggested by wikipedia.

The "hash join" algorithm consists of two steps:

1. Hash phase:
 1.1 - Create a multimap from one of the two tables, mapping from each join column value to all the rows that contain it. The multimap must support hash-based lookup which scales better than a simple linear s earch, because that's the whole point of this algorithm. Ideally we should create the multimap for the  smaller table, thus minimizing its creation time and memory size.

2. Join phase:
 2.1 - Scan the other table, and find matching rows by looking in the multimap created before.

Test Case

Input:

    @player_ages = (
        [20, "Alex"  ],
        [28, "Joe"   ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
    );

    @player_names = (
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    );

Output:

    Based on index = 1 of @players_age and index = 0 of @players_name.

    20, "Alex",  "Stewart"
    20, "Alex",  "Jones"
    18, "Alex",  "Stewart"
    18, "Alex",  "Jones"
    28, "Joe",   "Root"
    28, "Joe",   "Blog"
    38, "Mike",  "Gatting"
    18, "Simon", "Duane"

*/

import "fmt"

func main() {
	playerAges := []struct {
		value int
		key   string
	}{
		{20, "Alex"},
		{28, "Joe"},
		{38, "Mike"},
		{18, "Alex"},
		{25, "David"},
		{18, "Simon"},
	}

	playerNames := []struct {
		key   string
		value string
	}{
		{"Alex", "Stewart"},
		{"Joe", "Root"},
		{"Mike", "Gatting"},
		{"Joe", "Blog"},
		{"Alex", "Jones"},
		{"Simon", "Duane"},
	}

	// build the hash phase
	h := map[string][]int{}
	for n, a := range playerAges {
		h[a.key] = append(h[a.key], n)
	}

	// join phase
	for _, i := range playerNames {
		for _, j := range h[i.key] {
			fmt.Println("Based on index = 1 of", playerAges[j], "and index = 0 of", i.value)
		}
	}
}
