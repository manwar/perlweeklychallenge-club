package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestAngle(t *testing.T) {
	assert.Equal(t, float64(35), angle("03:10"), "Example 1")
	assert.Equal(t, float64(120), angle("04:00"), "Example 2")
}

func TestHoursAngle(t *testing.T) {
	expect := float64(((3 * 60) + 10) * .5)
	got := hourAngle("03", "10")
	assert.Equal(t, expect, got, "Example 1")
}

func TestMinuteAngle(t *testing.T) {
	expect := float64(6 * 10)
	got := minuteAngle("03", "10")
	assert.Equal(t, expect, got, "Example 1")
}
