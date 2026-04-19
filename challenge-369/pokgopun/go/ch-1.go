//# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/
/*#

Task 1: Valid Tag

Submitted by: [63]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a given a string caption for a video.

   Write a script to generate tag for the given string caption in three
   steps as mentioned below:
1. Format as camelCase
Starting with a lower-case letter and capitalising the first letter of each subs
equent word.
Merge all words in the caption into a single string starting with a #.
2. Sanitise the String
Strip out all characters that are not English letters (a-z or A-Z).
3. Enforce Length
If the resulting string exceeds 100 characters, truncate it so it is
exactly 100 characters long.

Example 1

Input: $caption = "Cooking with 5 ingredients!"
Output: "#cookingWithIngredients"

Example 2

Input: $caption = "the-last-of-the-mohicans"
Output: "#thelastofthemohicans"

Example 3

Input: $caption = "  extra spaces here"
Output: "#extraSpacesHere"

Example 4

Input: $caption = "iPhone 15 Pro Max Review"
Output: "#iphoneProMaxReview"

Example 5

Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled
 entirely by Artificial Intelligence and Voice Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialI
ntelligenceAndVoiceCommandsIn"

Task 2: Group Division
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"bytes"
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func validTag(caption string) string {
	ucf := false
	var d byte = 'a' - 'A'
	var b strings.Builder
	b.WriteByte('#')
	l := 1
	for _, v := range bytes.Trim([]byte(caption), " ") {
		if v >= 'a' && v <= 'z' {
			if ucf {
				v -= d
				ucf = false
			}
		} else if v >= 'A' && v <= 'Z' {
			if ucf {
				ucf = false
			} else {
				v += d
			}
		} else {
			if v == ' ' && ucf == false {
				ucf = true
			}
			continue
		}
		l++
		b.WriteByte(v)
		if l == 100 {
			break
		}
	}
	//fmt.Println(caption, "=>", b.String())
	return b.String()
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"Cooking with 5 ingredients!", "#cookingWithIngredients"},
		{"the-last-of-the-mohicans", "#thelastofthemohicans"},
		{"  extra spaces here", "#extraSpacesHere"},
		{"iPhone 15 Pro Max Review", "#iphoneProMaxReview"},
		{"Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!", "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(validTag(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
