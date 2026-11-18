package ch2

func minimumGeneticMutation(start, end string, bank []string) int {
	if start == end {
		return 0
	}

	valid := make(map[string]struct{}, len(bank))
	for _, g := range bank {
		valid[g] = struct{}{}
	}
	if _, ok := valid[end]; !ok {
		return -1
	}

	type node struct {
		gene  string
		steps int
	}

	const letters = "ACGT"

	seen := map[string]struct{}{start: {}}
	queue := []node{{start, 0}}

	for len(queue) > 0 {
		cur := queue[0]
		queue = queue[1:]

		buf := []byte(cur.gene)
		for i, orig := range buf {
			for j := 0; j < len(letters); j++ {
				c := letters[j]
				if c == orig {
					continue
				}

				buf[i] = c
				next := string(buf)

				if _, ok := valid[next]; !ok {
					continue
				}
				if _, ok := seen[next]; ok {
					continue
				}
				seen[next] = struct{}{}

				if next == end {
					return cur.steps + 1
				}
				queue = append(queue, node{next, cur.steps + 1})
			}
			buf[i] = orig // restore before moving to the next position
		}
	}
	return -1
}
