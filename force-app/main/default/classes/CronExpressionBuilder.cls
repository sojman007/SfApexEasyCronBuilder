/**
 *  @author : Olaitan Adesoji 6/2/2022
 *  @description : Allows you to build  cron expressions the easy way. Extensible and overrideable.
 *  Open source. 
 */
public without sharing virtual class CronExpressionBuilder {
    
    private Map<String,string> cronExpressionMap ; 
    



    public CronExpressionBuilder() {
        cronExpressionMap = new Map<String,string>{
            'Seconds'=>'',
            'Minutes' =>'',
            'Hours' =>'',
            'Day_of_month' =>'',
            'Month' =>'',
            'Day_of_week' =>'',
            'Optional_year' =>''
        };
    }

    public virtual CronExpressionBuilder setSeconds(integer seconds){
        cronExpressionMap.put('Seconds', String.valueOf(seconds));
        return this;
    }

    public virtual CronExpressionBuilder setMinutes(integer minutes){
        cronExpressionMap.put('Minutes', String.valueOf(minutes));
        return this;
    }
    public virtual CronExpressionBuilder setHours(integer hours){
        cronExpressionMap.put('Hours', String.valueOf(hours));
        return this;
    }

    public virtual CronExpressionBuilder setDayOfMonth(integer dayOfMonth){
        cronExpressionMap.put('Day_of_month', String.valueOf(dayOfMonth));
        return this;
    }
    public virtual CronExpressionBuilder setMonthNumber(integer month){
        cronExpressionMap.put('Month', String.valueOf(month));
        return this;
    }
    public virtual CronExpressionBuilder setMonthName(string monthAbbr){
        cronExpressionMap.put('Day_of_week', monthAbbr);
        return this;
    }

    public virtual CronExpressionBuilder setDayOfWeek(integer dayOfWeek){
        cronExpressionMap.put('Seconds', String.valueOf(dayOfWeek));
        return this;
    }
    public virtual CronExpressionBuilder setOptionalYear(integer optionalYear){
        cronExpressionMap.put('Optional_year', String.valueOf(optionalYear));
        return this;
    }


    public static string getCronForDateTime(Datetime instantDate){
        integer second = instantDate.second();
        integer currentMin = instantDate.minute();
        integer currentHour = instantDate.hour();
        integer dayOfMonth = instantDate.day();
        integer month = instantDate.month();
        string cronString =   second + ' ' 
                            + currentMin  + ' '
                            + currentHour + ' ' 
                            + dayOfMonth + ' '  
                            + month + ' ? ' 
                            + instantDate.year();
        return cronString;
    }



    public virtual boolean isValid(){
        string jobId = '';
        try{
           jobId = System.schedule('CronBuilderApexFaux' , this.get() , new CronExpressionBuilder.CronExpressionRandomSchedulableClass());
        }catch(Exception e){
            return false;
        }
        if(String.isNotBlank(jobId)){
            System.abortJob(jobId);
        } 
        return true;

    }



    public virtual string get(){
        string res = '';
        for(string placeholder : cronExpressionMap.keySet()){
            if(cronExpressionMap.get(placeholder) != null){
                res += string.valueOf(cronExpressionMap.get(placeholder));
            }
            
        }
        return res; 
    }


    /**
     * @author : Olaitan Adesoji 6/2/2022
     * @description : This class is a basic random mock class that we use to validate that a cron expression is valid
     * Not entirely used for anything else since we are relying on Salesforce to help us validate.
     */ 
    public class CronExpressionRandomSchedulableClass implements Schedulable{

        public void execute(SchedulableContext ctx){
            System.debug('Executing!!!');
        }

     }




}
