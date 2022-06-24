package sleepsort

import (
	"sync"
	"time"
)

func Sort(s []uint, d time.Duration) (r []uint) {
	l := len(s)
	//done := make(chan struct{})
	out := make(chan uint, l)
	var wg sync.WaitGroup
	wg.Add(l)
	for _, v := range s {
		go func(i uint) {
			//<-done
			defer wg.Done()
			time.Sleep(d * time.Duration(i))
			out <- i
		}(v)
	}
	go func() {
		//close(done)
		wg.Wait()
		close(out)
	}()

	for v := range out {
		r = append(r, v)
	}
	return r
}
