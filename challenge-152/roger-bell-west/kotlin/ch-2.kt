import kotlin.math.min
import kotlin.math.max

class Rect(_xy1: List<Int>, _xy2: List<Int>) {
        val xy1=listOf(
            min(_xy1[0],_xy2[0]),
            min(_xy1[1],_xy2[1]),
        );
        val xy2=listOf(
            max(_xy1[0],_xy2[0]),
            max(_xy1[1],_xy2[1]),
        );

        fun area(): Int {
            var area=1
            for (axis in 0..1) {
                area *= xy2[axis]-xy1[axis]
            }
            return area
        }
        
        fun overlap(other: Rect): Int {
            var area=1
            for (axis in 0..1) {
                area *= max(0,
                            min(xy2[axis],other.xy2[axis])-
                            max(xy1[axis],other.xy1[axis])
                            )
            }
            return area
        }
        
        fun fullarea(other: Rect): Int {
            return area()+other.area()-overlap(other)
        }
}

fun main() {
    if (Rect(listOf(-1,0),listOf(2,2))
            .fullarea(Rect(listOf(0,-1),listOf(4,4)))
            == 22) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (Rect(listOf(-3,-1),listOf(1,3))
            .fullarea(Rect(listOf(-1,-3),listOf(2,2)))
            == 25) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
