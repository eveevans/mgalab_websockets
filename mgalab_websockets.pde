import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.HttpClient;

import com.pusher.client.Pusher;
import com.pusher.client.channel.Channel;
import com.pusher.client.channel.SubscriptionEventListener;

import http.requests.*;

DonationCollection donations;

void setup(){  
  size(200,200);
  donations = new DonationCollection();
  
  PusherOptions options = new PusherOptions();
  options.setCluster("us2");
  Pusher pusher = new Pusher("", options);
  Channel channel = pusher.subscribe("donations");
        
  channel.bind("new_donation", new SubscriptionEventListener() {
    @Override
    public void onEvent(String channelName, String eventName, final String data) {
      System.out.println(data);    
      JSONObject donationObj = parseJSONObject(data);     
      println( donationObj.getString("donor") );
      println( donationObj.getFloat("amount") );
      println( donationObj.getBoolean("anonymous") );

      donations.add( donationObj.getString("donor"), donationObj.getFloat("amount"), donationObj.getBoolean("anonymous")   );
    }
  });
  
  pusher.connect();
}

void draw(){
  donations.update();
}