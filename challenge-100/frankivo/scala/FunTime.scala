object FunTime {
    val examples = Seq[String](
        "07:04am",
        "08:24pm",
        "08:24am",
        "09:39 am",
        "08:24",
        "11:59",
        "12:00",
        "12:01",
        "12:34",
        "13:37",
        "20:24",
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
       val parsed = getTime(time)
       
       val suffix = if (parsed._1 < 12) "am" else "pm"
       val hour = if (parsed._1 > 12) parsed._1 - 12 else parsed._1

       makeTime(hour, parsed._2, suffix)
    }

    def to24H(time: String): String = {
        val parsed = getTime(time)
        val hour = if (time.contains("pm")) parsed._1 + 12 else parsed._1
        
        makeTime(hour, parsed._2)
    }

    def convert(time: String) : String = {
        if (("(am|pm)$".r findFirstIn time).isDefined)
            to24H(time)
        else
            to12H(time)
    }

    def main(args: Array[String]): Unit = {
        examples
            .map(convert)
            .foreach(println)
    }
}