object FunTime {
    val examples = Seq[String](
        "08:24pm",
        "08:24am",
        "09:39 am",
        "08:24",
        "20:24",
        "13:37",
        "12:34"
    )


    def to12H(time: String): Option[String] = {
       
        None
    }

    def to24H(time: String): Option[String] = {
        if (!("(am|pm)$".r findFirstIn time).isDefined)
            return None
        
        val h :: m :: _ = ("([0-9]{2})".r findAllIn time).toSeq
        val hour = if (time.contains("pm")) h.toInt + 12 else h
        
        Some(s"$hour:$m")
    }

    def main(args: Array[String]): Unit = {
        examples
            .map(e => Seq(to12H(e), to24H(e)))
            .flatten
            .flatten
            .foreach(println)
    }
}