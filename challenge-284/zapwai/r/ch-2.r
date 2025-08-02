proc <- function(l1, l2) {
    cat( "Input: \n list1 = ", l1, "\n list2 = ", l2 )
    tail = c()
    for (item in list1) {
	elem_of_l2_flag = 0
	for (item2 in list2) {
	    if (item == item2) {
		elem_of_l2_flag = 1
                break
	    }
	}
	if (elem_of_l2_flag == 0) {
	    tail <- append(tail, item)
	}
    }
    out = c()
    for (item2 in list2) {
	for (item in list1) {
	    if (item == item2) {
		out <- append(out, item)
	    }
	}
    }
    sorted_tail <- sort(tail)
    cat( "\nOutput: ", out, sorted_tail, "\n" )
}

list1 = c(2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
list2 = c(2, 1, 4, 3, 5, 6)
proc(list1, list2)
list1 = c(3, 3, 4, 6, 2, 4, 2, 1, 3)
list2 = c(1, 3, 2)
proc(list1, list2)
list1 = c(3, 0, 5, 0, 2, 1, 4, 1, 1)
list2 = c(1, 0, 3, 2)
proc(list1, list2)
