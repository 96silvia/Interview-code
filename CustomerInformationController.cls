public class CustomerInformationController {
    public static string results;
    public static List<Object> customerArray{get; set;}
    public static Integer size{get; set;}
    public static Decimal finalTotal {get; set;}
    public static List<customerData> customerDataList {get;set;}
    //method to get the json from github
    public static List<Object> getJsonString(){       
      Http httpProtocol = new Http();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'https://raw.githubusercontent.com/StrategicFS/Recruitment/master/data.json';
      request.setEndpoint(endpoint);
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        //System.debug(response.getBody());
        results = response.getBody();
        System.debug(results);
        List<Object> fieldList = (List<Object>)Json.deserializeUntyped(results);
        //for (object a : customermap.Values()){
        // System.debug('map results'+a);   
        //}
         return fieldList;
    }
    public static void getData(){
      String success;
      Decimal runningTotal = 0;
          customerArray = getJsonString();
          customerDataList = new List<CustomerData>();
            for (Object obj:customerArray){
            String testString = json.serialize(obj);  
       System.debug('test value'+ testString);
            Map<String, Object> respMap = (Map<String, Object>) JSON.deserializeUntyped(testString);
            customerData cData = new customerData();        
            cData.creditorName = (String)respMap.get('creditorName');
            cData.firstName = (String)respMap.get('firstName');
            cData.lastName = (String)respMap.get('lastName');
            cData.minPaymentPercentage = (Decimal)respMap.get('minPaymentPercentage');
            runningTotal = runningTotal+(Decimal)respMap.get('balance');    
            cData.balance = (Decimal)respMap.get('balance');
            customerDataList.add(cData);  
        }
        
        finalTotal = runningTotal;
        size = customerDataList.size();
        System.debug('finalTotal: '+finalTotal);
        System.debug('size :'+size);
        //return  customerArray;
    } 
        public class customerData{
        public String creditorName {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public Decimal minPaymentPercentage {get;set;}
        public Decimal balance {get;set;}
            
    }
}