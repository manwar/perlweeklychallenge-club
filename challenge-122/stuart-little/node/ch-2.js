#!/usr/bin/env node

// run <script> <score>

function comp(nr,bd){
    tab=[[[],],]
    for (let n=1; n <= nr; n++){
        item=[]
        for (let i=1; i <= bd; i++){
            if (tab.length >= i){
		suppPrev = tab.slice(-i)[0].map( ar => [i].concat(ar) )
		item = item.concat(suppPrev)
	    }
	}
        if (tab.length >= bd) { tab=tab.slice(1) }        
        tab.push(item)
    }
    return tab.slice(-1)[0]
}

for (cmp of comp(parseInt(process.argv[2]), 3)) {
    console.log(cmp)
}
