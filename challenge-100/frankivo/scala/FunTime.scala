object FunTime {
    val examples = Seq[String](
        "07:04am",
        "08:24pm",
        "08:24am",
        "09:39 am",
        "08:24",
        "20:24",
        "13:37",
        "12:34",
        "18:04"
    )

    def getTime(time: String) : (Int, Int) = {
        val h :: m :: _ = ("([0-9]{2})".r findAllIn time).toSeq
        (h.toInt, m.toInt)
    }

    def makeTime(hour: Int, minute: Int, suffix: String = "") = {
        "%02d:%02d%s".format(hour, minute, " " + suffix)
    }

    def to12H(time: String): String = {
       time
    }

    def to24H(time: String): String = {
        val parsed = getTime(time)
        val hour = if (time.contains("pm")) parsed._1 + 12 else parsed._1
        
        makeTime(hour, parsed._2)
    }

    def main(args: Array[String]): Unit = {
        examples
            .map(e => {
                if (("(am|pm)$".r findFirstIn e).isDefined)
                    to24H(e)
                else
                    to12H(e)
            })
            .foreach(println)
    }
}