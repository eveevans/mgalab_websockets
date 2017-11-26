import http.requests.*;

//String donationsURL = "https://powerful-escarpment-79804.herokuapp.com/donations.json";
String donationsURL = "http://localhost:3000/donations.json";

class DonationCollection {
  
  ArrayList<DonationSprite> donations; 
  Float totalAmount = 0.0;
  Integer donationsCount = 0;
  
  DonationCollection(){    
    donations = new ArrayList<DonationSprite>();
        
    GetRequest get = new GetRequest(donationsURL);
    //get.addUser("username", "password");
    get.send();
    println("Reponse Content: " + get.getContent());
    JSONObject json = parseJSONObject(  get.getContent() );
    JSONObject meta = json.getJSONObject("meta");
    
    totalAmount =     meta.getFloat("total_amount");
    donationsCount =  meta.getInt("donations_count");    
        
    JSONArray donors = json.getJSONArray("data");
    for (int i = 0; i < donors.size(); i++){
      JSONObject donationObj = donors.getJSONObject(i);
      
      DonationSprite ds = new DonationSprite( donationObj.getInt("id"), donationObj.getString("donor"), donationObj.getFloat("amount"), donationObj.getBoolean("anonymous") );
      donations.add( ds );
    }
    
  }
  
  void add(DonationSprite ds){
    donations.add(ds);
  }
  
  void updateTotalAmount(Float newTotal){
    totalAmount = newTotal;
  }
  
  void updateDonationsCount(Integer newDonationsTotal){
    donationsCount = newDonationsTotal;
  }
  
  void removeDonationWithId(Integer donationID){    
    for (int i = donations.size() - 1; i >= 0; i--) {      
      DonationSprite donation = donations.get(i);      
      if(donation.donationId() == donationID){
        donations.remove(i);
      }            
    }    
  }
  
  void update(){
    
    // Draw Total
    fill(60);
    textSize(60);
    text( "$ " + totalAmount,  0,0,1920,800);
    
    // Draw Donations Count
    text( str(donationsCount),  0,200,1920,800);  
    
    // Draw City
    for(DonationSprite d : donations){
      line(0,0,d.donationAmount(), d.donationAmount() );      
        //String s = "Cualquier cosa";
        fill(50);
        textSize(72);
        text(d.donationName(),d.donationAmount(),d.donationAmount(),800,800);
        text(str(d.donationAmount()),d.donationAmount(),d.donationAmount()+30, 800, 800);      
    }    
    
    // Draw last 5
    fill(50);
    textSize(72);    
    for (int i = donations.size() - 1, j=0; i >= (Math.max(donations.size() - 5, 0)); i--, j++) {               
      text(str(donations.get(i).donationAmount()), (j*382) ,450, ( j*384 + 384 ),540);      
    }    
    
  }
  
}