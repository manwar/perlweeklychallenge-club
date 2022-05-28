package main

import (
	"fmt"
	"regexp"
	"strings"
)

func main() {
	pass1, msg1 := "playfair example", "hide the gold in the tree stump"
	pf1, _ := New(pass1)
	res1, err := pf1.Encrypt(msg1)
	fmt.Printf("encrypt(%q, %q) = %q => %t, err => %v\n", pass1, msg1, res1, res1 == "bmodzbxdnabekudmuixmmouvif", err)

	pass2, msg2 := "perl and raku", "siderwrdulfipaarkcrw"
	pf2, _ := New(pass2)
	res2, err := pf2.Decrypt(msg2)
	fmt.Printf("encrypt(%q, %q) = %q => %t, err => %v\n", pass2, msg2, res2, res2 == "thewexeklychallengex", err)
}

func isLowercaseLetter(s string) bool {
	re := regexp.MustCompile(`^[a-z]+$`)
	return re.MatchString(s)
}
func lowerCaseAndRemoveSpace(s string) string {
	return regexp.MustCompile(`\s`).ReplaceAllLiteralString(strings.ToLower(s), "")
}

func insertX(s string) string {
	sep := "x"[0]
	var b strings.Builder
	var seen byte
	for _, v := range []byte(s) {
		if v == seen {
			b.WriteByte(sep)
		}
		b.WriteByte(v)
		seen = v
	}
	if b.Len()%2 != 0 {
		b.WriteByte(sep)
	}
	return b.String()
}

type inputType int

const (
	passphrase inputType = iota
	msg2encrypt
	msg2decrypt
)

func (ipt inputType) String() string {
	switch ipt {
	case passphrase:
		return "passphrase"
	case msg2encrypt:
		return "msg2encrypt"
	case msg2decrypt:
		return "msg2decrypt"
	default:
		return "unknown"
	}
}

type input struct {
	val string
	t   inputType
}

func newInput(t inputType, s string) (r input, err error) {
	fname := "newInput"
	r = input{lowerCaseAndRemoveSpace(s), t}
	ok := isLowercaseLetter(r.val)
	switch t {
	case passphrase:
		if !ok {
			return input{}, fmt.Errorf("%v: %v can only contain english and space characters", fname, t)
		}
	case msg2encrypt:
		if !ok {
			return input{}, fmt.Errorf("%v: %v can only contain english and space characters", fname, t)
		}
		r.val = insertX(r.val)
	case msg2decrypt:
		if !isLowercaseLetter(strings.ToLower(s)) || len(s)%2 != 0 {
			return input{}, fmt.Errorf("%v: %v not encrypted by playfair", fname, t)
		}
	default:
		return input{}, fmt.Errorf("%v: inputType %v is not supported", fname, t)
	}
	return r, nil
}

type rowcol struct{ row, col int }

type playfair struct {
	char2rc map[byte]rowcol
	chars   [5][5]byte
}

func (pf playfair) String() (s string) {
	var b strings.Builder
	for _, r := range pf.chars {
		for _, c := range r {
			fmt.Fprintf(&b, "%2s%v", string(c), pf.char2rc[c])
		}
		b.WriteByte("\n"[0])
	}
	return b.String()
}

func (pf playfair) convert(m input) (string, error) {
	fname := "convert"
	var o int
	switch m.t {
	case msg2encrypt:
		o = 1
	case msg2decrypt:
		o = 4
	default:
		return "", fmt.Errorf("%v: only msg2encrypt/msg2decrypt are processed", fname)
	}
	b := []byte(m.val)
	var r strings.Builder
	for i := 0; i < len(b); i += 2 {
		x, y := pf.char2rc[b[i]], pf.char2rc[b[i+1]]
		switch {
		case x.row == y.row:
			x.col = (x.col + o) % 5
			y.col = (y.col + o) % 5
		case x.col == y.col:
			x.row = (x.row + o) % 5
			y.row = (y.row + o) % 5
		default:
			x.col, y.col = y.col, x.col
		}
		r.Write([]byte{pf.chars[x.row][x.col], pf.chars[y.row][y.col]})
	}
	return r.String(), nil
}

func (pf playfair) Encrypt(s string) (string, error) {
	msg, err := newInput(msg2encrypt, s)
	if err != nil {
		return "", fmt.Errorf("Encrypt: %w", err)
	}
	return pf.convert(msg)
}

func (pf playfair) Decrypt(s string) (string, error) {
	msg, err := newInput(msg2decrypt, s)
	if err != nil {
		return "", fmt.Errorf("Decrypt: %w", err)
	}
	return pf.convert(msg)
}

func chars(start byte, end byte) string {
	var sb strings.Builder
	for i := start; i <= end; i++ {
		sb.WriteByte(i)
	}
	return sb.String()
}

func New(s string) (pf playfair, err error) {
	fname := "New"
	pass, err := newInput(passphrase, s)
	if err != nil {
		return playfair{}, fmt.Errorf("%v: %w", fname, err)
	}
	pf.char2rc = make(map[byte]rowcol, 26)
	var row, col int
	for _, b := range []byte(pass.val + chars("a"[0], "z"[0])) {
		_, ok := pf.char2rc[b]
		if ok {
			continue
		}
		if b == "i"[0] || b == "j"[0] {
			for _, k := range []byte("ij") {
				pf.char2rc[k] = rowcol{row, col}
			}
		} else {
			pf.char2rc[b] = rowcol{row, col}
		}
		pf.chars[row][col] = b
		if col < 4 {
			col++
		} else {
			col = 0
			row++
			if row > 4 {
				break
			}
		}
	}
	return pf, nil
}
