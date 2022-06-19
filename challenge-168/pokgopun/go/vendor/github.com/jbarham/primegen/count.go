package primegen

var pop = []uint32{
	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8}

// Count returns the number of prime numbers from the generator's current
// position up to x.
func (pg *Primegen) Count(x uint64) uint64 {
	var count uint64 = 0
	var smallcount, bits uint32

	for {
		for pg.num != 0 {
			if pg.p[pg.num-1] >= x {
				return count
			}
			count++
			pg.num--
		}

		smallcount = 0
		pos := pg.pos
		for (pos < _B32) && (pg.base+1920 < x) {
			for j := 0; j < 16; j++ {
				bits = ^pg.buf[j][pos]
				smallcount += pop[bits&255]
				bits >>= 8
				smallcount += pop[bits&255]
				bits >>= 8
				smallcount += pop[bits&255]
				bits >>= 8
				smallcount += pop[bits&255]
			}
			pg.base += 1920
			pos++
		}
		pg.pos = pos
		count += uint64(smallcount)

		if pos == _B32 {
			for pg.base+_B*60 < x {
				pg.sieve()
				pg._L += _B

				smallcount = 0
				for j := 0; j < 16; j++ {
					for pos = 0; pos < _B32; pos++ {
						bits = ^pg.buf[j][pos]
						smallcount += pop[bits&255]
						bits >>= 8
						smallcount += pop[bits&255]
						bits >>= 8
						smallcount += pop[bits&255]
						bits >>= 8
						smallcount += pop[bits&255]
					}
				}
				count += uint64(smallcount)
				pg.base += _B * 60
			}
		}

		pg.fill()
	}
	return count // Shouldn't get here.
}
