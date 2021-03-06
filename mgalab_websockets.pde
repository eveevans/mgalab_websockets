import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.HttpClient;

import com.pusher.client.Pusher;
import com.pusher.client.channel.Channel;
import com.pusher.client.channel.SubscriptionEventListener;

import codeanticode.syphon.*;
SyphonServer server;

DonationCollection donations;

void setup(){  
  size(3840,540,P3D);
  server = new SyphonServer(this, "ANF");
  donations = new DonationCollection();
  
  PusherOptions options = new PusherOptions();
  options.setCluster("us2");
  Pusher pusher = new Pusher("99ee4be413cdd3ef5262", options);
  Channel channel = pusher.subscribe("donations");
        
  channel.bind("new_donation", new SubscriptionEventListener() {
    @Override
    public void onEvent(String channelName, String eventName, final String data) {
      System.out.println(data);    
      JSONObject donationObj = parseJSONObject(data);      
      DonationSprite ds = new DonationSprite( donationObj.getInt("id"),  donationObj.getString("donor"), donationObj.getFloat("amount"), donationObj.getBoolean("anonymous") );
      donations.add( ds );
      donations.updateTotalAmount( donationObj.getFloat("totalAmount")  );
      donations.updateDonationsCount( donationObj.getInt("donationsCount") );
    }
  });
    
  channel.bind("delete_donation", new SubscriptionEventListener() {
    @Override
    public void onEvent(String channelName, String eventName, final String data) {
      System.out.println("DELEEEETE");    
      JSONObject donationObj = parseJSONObject(data);
            
      donations.updateTotalAmount( donationObj.getFloat("totalAmount")  );
      donations.updateDonationsCount( donationObj.getInt("donationsCount") );
      donations.removeDonationWithId( donationObj.getInt("id") );
    }
  });
  
  pusher.connect();
}

void draw(){
  background(0,0,0,255);
  donations.update();
  //server.sendScreen();
}