package main

func similarList(list1, list2 []string, list3 [][]string) bool {
	if len(list1) != len(list2) {
		return false
	}

	wordToGp := make(map[string]string)
	for _, gp := range list3 {
		if len(gp) == 0 {
			continue
		}
		rep := gp[0]
		for _, w := range gp {
			wordToGp[w] = rep
		}
	}

	for i := 0; i < len(list1); i++ {
		w1, w2 := list1[i], list2[i]
		if w1 == w2 {
			continue
		}
		gp1, exists1 := wordToGp[w1]
		gp2, exists2 := wordToGp[w2]
		if !exists1 || !exists2 {
			return false
		}
		if gp1 != gp2 {
			return false
		}
	}
	return true
}
