import http.requests.*;

String donationsURL = "https://powerful-escarpment-79804.herokuapp.com/donations.json";
//String donationsURL = "http://localhost:3000/donations.json";

class DonationCollection {
  
  ArrayList<DonationSprite> donations; 
  Float totalAmount = 0.0;
  
  DonationCollection(){    
    donations = new ArrayList<DonationSprite>();
        
    GetRequest get = new GetRequest(donationsURL);
    //get.addUser("username", "password");
    get.send();
    println("Reponse Content: " + get.getContent());
    JSONObject json = parseJSONObject(  get.getContent() );
    JSONObject meta = json.getJSONObject("meta");
    totalAmount = meta.getFloat("total_amount");
    
    println(totalAmount);
    //meta -> total_amount
    
    //JSONArray values = json.getJSONArray("data");
    
  }
  
  void add(DonationSprite ds){
    donations.add(ds);
  }
  
  void updateTotalAmount(Float newTotal){
    totalAmount = newTotal;
  }
  
  void update(){
    
    fill(60);
    textSize(60);
    text( str(totalAmount),  0,0,1920,800);
    
    for(DonationSprite d : donations){
      line(0,0,d.donationAmount(), d.donationAmount() );
      
        //String s = "Cualquier cosa";
        fill(50);
        textSize(72);
        text(d.donationName(),d.donationAmount(),d.donationAmount(),800,800);
        text(str(d.donationAmount()),d.donationAmount(),d.donationAmount()+30, 800, 800);
      
    }
  }
  
}