import java.util.Arrays

fun main() {
    val tests  = arrayOf(arrayOf(intArrayOf(3,),
                                 intArrayOf(1,4,2,3,5)),
                         arrayOf(intArrayOf(4,),
                                 intArrayOf(9,0,6,2,3,8,5))
                        )

    for (test in tests) {
        print(Arrays.deepToString(test) + "  =>  ")
        var i = test[0][0]
        var nums = test[1];
        for (j in nums) {
            if (j > i) {
                print(j.toString() + " ")
            }
        }
        println("")

    }
}
