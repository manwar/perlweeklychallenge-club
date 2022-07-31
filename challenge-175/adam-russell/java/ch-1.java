import java.util.Calendar;

class LastSunday{
    private static String lastSundayMonth(int month, int year){
        int day = 20;
        Calendar c = Calendar.getInstance();
        c.set(year, month, day);
        int lastSunday = day; 
        while(day <= c.getActualMaximum(Calendar.DATE)){  
            c.set(Calendar.DATE, day);
            if(c.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)
                lastSunday = day; 
            day++; 
        }
        month++;
        String m = String.valueOf(month); 
        if(month < 10)
            m = "0" + m;  
        return year + "-" + m + "-" + lastSunday;  
    }
    
    public static String[] lastSunday(int year){
        int month = 0; 
        String lastSunday[] = new String[12]; 
        while(month < 12){
            lastSunday[month] = lastSundayMonth(month, year);  
            month++; 
        } 
        return lastSunday;
    }  

    public static void main(String[] args){
        String[] lastSunday = lastSunday(2022);
        for(int i = 0; i < lastSunday.length; i++)
            System.out.println(lastSunday[i]);   
    }  
}
