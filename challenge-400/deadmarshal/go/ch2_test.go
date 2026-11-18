package ch2

import "testing"

func TestMinimumGeneticMutation(t *testing.T) {
	tests := []struct {
		name  string
		start string
		end   string
		bank  []string
		want  int
	}{
		{
			name:  "Example 1",
			start: "AACCGGTT",
			end:   "AACCGGTA",
			bank:  []string{"AACCGCTA", "AAACGGTA"},
			want:  -1,
		},
		{
			name:  "Example 2",
			start: "AACCGGTT",
			end:   "AACCGGAA",
			bank:  []string{"AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"},
			want:  2,
		},
		{
			name:  "Example 3",
			start: "AAAAAAAA",
			end:   "AAAAACCC",
			bank:  []string{"CAAAAAAA", "CCAAAAAA", "AAAAAAAC"},
			want:  -1,
		},
		{
			name:  "Example 4",
			start: "GAAAAAAA",
			end:   "GCCCCCCC",
			bank: []string{
				"GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA",
				"GCCCCCAA", "GCCCCCCA", "GCCCCCCC",
			},
			want: 7,
		},
		{
			name:  "Example 5",
			start: "AACCGGTT",
			end:   "AACCGGTT",
			bank:  []string{"AACCGGTA"},
			want:  0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := minimumGeneticMutation(tt.start, tt.end, tt.bank)
			if got != tt.want {
				t.Errorf("minimumGeneticMutation(%q, %q, %v) = %d, want %d",
					tt.start, tt.end, tt.bank, got, tt.want)
			}
		})
	}
}
