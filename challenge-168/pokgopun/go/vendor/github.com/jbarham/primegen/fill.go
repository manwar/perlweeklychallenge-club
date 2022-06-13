package primegen

func (pg *Primegen) fill() {
	var bits0, bits1, bits2, bits3, bits4, bits5, bits6, bits7 uint32
	var bits8, bits9, bits10, bits11, bits12, bits13, bits14, bits15 uint32

	i := pg.pos
	if i == _B32 {
		pg.sieve()
		pg._L += _B
		i = 0
	}
	pg.pos = i + 1

	bits0 = ^pg.buf[0][i]
	bits1 = ^pg.buf[1][i]
	bits2 = ^pg.buf[2][i]
	bits3 = ^pg.buf[3][i]
	bits4 = ^pg.buf[4][i]
	bits5 = ^pg.buf[5][i]
	bits6 = ^pg.buf[6][i]
	bits7 = ^pg.buf[7][i]
	bits8 = ^pg.buf[8][i]
	bits9 = ^pg.buf[9][i]
	bits10 = ^pg.buf[10][i]
	bits11 = ^pg.buf[11][i]
	bits12 = ^pg.buf[12][i]
	bits13 = ^pg.buf[13][i]
	bits14 = ^pg.buf[14][i]
	bits15 = ^pg.buf[15][i]

	base := pg.base + 1920
	pg.base = base

	pg.num = 0

	for mask := uint32(0x80000000); mask != 0; mask >>= 1 {
		base -= 60
		if bits15&mask != 0 {
			pg.p[pg.num] = base + 59
			pg.num++
		}
		if bits14&mask != 0 {
			pg.p[pg.num] = base + 53
			pg.num++
		}
		if bits13&mask != 0 {
			pg.p[pg.num] = base + 49
			pg.num++
		}
		if bits12&mask != 0 {
			pg.p[pg.num] = base + 47
			pg.num++
		}
		if bits11&mask != 0 {
			pg.p[pg.num] = base + 43
			pg.num++
		}
		if bits10&mask != 0 {
			pg.p[pg.num] = base + 41
			pg.num++
		}
		if bits9&mask != 0 {
			pg.p[pg.num] = base + 37
			pg.num++
		}
		if bits8&mask != 0 {
			pg.p[pg.num] = base + 31
			pg.num++
		}
		if bits7&mask != 0 {
			pg.p[pg.num] = base + 29
			pg.num++
		}
		if bits6&mask != 0 {
			pg.p[pg.num] = base + 23
			pg.num++
		}
		if bits5&mask != 0 {
			pg.p[pg.num] = base + 19
			pg.num++
		}
		if bits4&mask != 0 {
			pg.p[pg.num] = base + 17
			pg.num++
		}
		if bits3&mask != 0 {
			pg.p[pg.num] = base + 13
			pg.num++
		}
		if bits2&mask != 0 {
			pg.p[pg.num] = base + 11
			pg.num++
		}
		if bits1&mask != 0 {
			pg.p[pg.num] = base + 7
			pg.num++
		}
		if bits0&mask != 0 {
			pg.p[pg.num] = base + 1
			pg.num++
		}
	}
}
