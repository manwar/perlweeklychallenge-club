package main

import (
	"fmt"
	"log"
	"os"
	"time"
)

type input struct {
	t time.Time
	d time.Duration
}

func main() {
	guide := `Please provide timestamp (i.e. "2006-01-30 17:07") and duration (i.e. "1.5h" or "2h45m") as arguments.`
	samples := []input{
		input{
			time.Date(2022, 8, 1, 10, 30, 0, 0, time.UTC),
			4 * time.Hour,
		},
		input{
			time.Date(2022, 8, 1, 17, 0, 0, 0, time.UTC),
			3*time.Hour + 30*time.Minute,
		},
	}
	if len(os.Args) < 2 {
		log.Fatal(guide, "\n\nExample:\n\n", output(samples))
	}
	t, err := time.Parse("2006-01-02 15:04", os.Args[1])
	if err != nil {
		log.Fatal(guide, "\n\nExample:\n\n", output(samples))
	}
	d, err := time.ParseDuration(os.Args[2])
	if err != nil || d < 0 {
		log.Fatal(guide, "\n\nExample:\n\n", output(samples))
	}
	fmt.Print(output([]input{input{t, d}}))
}

func output(inputs []input) (s string) {
	for _, input := range inputs {
		s += fmt.Sprintf(
			"Given timestamp %q and duration %q,\nthe next business date is %q\n\n",
			input.t.Format("2006-01-02 15:04"),
			input.d,
			bizDate(input.t, input.d).Format("2006-01-02 15:04:05"),
		)
	}
	return s
}

func bizDate(t time.Time, d time.Duration) time.Time {
	var o int
	if t.Weekday() == time.Saturday {
		o = 2
	} else {
		o = int(time.Monday - t.Weekday())
	}
	if t.Weekday()%6 != 0 {
		dur := t.Sub(time.Date(t.Year(), t.Month(), t.Day(), 9, 0, 0, 0, t.Location()))
		switch {
		case dur < 0:
		case dur < 9*time.Hour:
			d += dur
		case dur >= 9*time.Hour:
			d += 9 * time.Hour
		}
		d += time.Duration(t.Weekday()-1) * 9 * time.Hour
	}
	dWeeks := int(d / (45 * time.Hour))
	dDays := int((d % (45 * time.Hour)) / (9 * time.Hour))
	dHours := (d % (45 * time.Hour)) % (9 * time.Hour)
	//fmt.Printf("d=%v\nweeks=%v\ndays=%v\nhours=%v\n", d, dWeeks, dDays, dHours)
	t = time.Date(t.Year(), t.Month(), t.Day()+o, 9, 0, 0, 0, t.Location())
	t = t.AddDate(0, 0, 7*dWeeks+dDays)
	t = t.Add(dHours)
	return t
}
