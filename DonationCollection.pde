import http.requests.*;

//String donationsURL = "https://powerful-escarpment-79804.herokuapp.com/donations.json";
String donationsURL = "http://localhost:3000/donations.json";

class DonationCollection {
  
  ArrayList<DonationSprite> donations; 
  Float totalAmount = 0.0;
  Integer donationsCount = 0;
  PImage[] lands = new PImage[25];
  PImage anfLogo;
  
  DonationCollection(){
    
    anfLogo = loadImage("anfLogo.png");
    
    // initializing images
    for(int i = 0; i < lands.length; i++){
      lands[i] = loadImage("land"+i+".png");
    }
    
    // Initilizing archive donations
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
    // Draw background Image based on count
    Integer currentLand = donationsCount % lands.length;    
    image(lands[currentLand],0,0);
    
    // Drag Logos
    // Integer logosTotal = donationsCount / lands.length;
    Integer logosTotal = donationsCount / 5;
    for(int i = 0; i < logosTotal; i++){
      image(anfLogo, ( 17 + 77 * i ), 88 );  // left
      image(anfLogo, ( 3840  - (77 * i) ), 88 ); // right
    }
    
    // Draw progressBar
    Float varWidth  = 40.0;
    Float varHeight = 235.0;
    fill(28,74,121,153);
    rect(55,165, varWidth, varHeight); // Left     
    rect(3740,165, varWidth, varHeight); // Right
    
    fill(255,120,67,153);
    Float stepBar = varHeight / lands.length;
    Float progressHeight = currentLand * stepBar;
    rect(55,165 + varHeight - progressHeight, varWidth, progressHeight);  // left
    rect(3740,165 + varHeight - progressHeight, varWidth, progressHeight);  // right
        
    // Draw last 4
    fill(255,255,255);
    textSize(36);    
    for (int i = donations.size() - 1, j=0; i >= (Math.max(donations.size() - 5, 0)); i--, j++) {
      textAlign(LEFT);
      text( "$" + donations.get(i).donationAmount() , 120 , ( 157 + j*51), 1920 , 540);
      textAlign(RIGHT);
      text( "$" + donations.get(i).donationAmount() , 120 , ( 157 + j*51), 3840 - 240 , 540);
    }
    
    // Draw Total LEFT
    textAlign(LEFT);
    fill(255,255,255);
    textSize(45);
    text( "$ " + totalAmount,  34, 408,3840,540);
    textAlign(RIGHT);
    text( "$ " + totalAmount,  34, 408, 3840 - 78 ,540);    
    textAlign(LEFT);
  }
  
}