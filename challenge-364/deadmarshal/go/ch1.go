package main

func decryptString(s string) string {
	var res []byte
	for i, n := 0, len(s); i < n; {
		if i+2 < n && s[i+2] == '#' {
			num := (int(s[i])-'0')*10 + int(s[i+1]) - '0'
			res = append(res, byte(num+int('a')-1))
			i += 3
		} else {
			num := int(s[i]) - '0'
			res = append(res, byte(num+int('a')-1))
			i++
		}
	}
	return string(res)
}
