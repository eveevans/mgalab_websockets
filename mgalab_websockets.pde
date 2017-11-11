import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.HttpClient;
import com.pusher.client.Pusher;
import com.pusher.client.channel.Channel;
import com.pusher.client.channel.SubscriptionEventListener;

void setup(){  
  size(200,200);
  PusherOptions options = new PusherOptions();
  options.setCluster("us2");
  Pusher pusher = new Pusher("", options);
  Channel channel = pusher.subscribe("my-channel");
  
  channel.bind("my-event", new SubscriptionEventListener() {
    @Override
    public void onEvent(String channelName, String eventName, final String data) {
      System.out.println(data);
    }
  });
  
  pusher.connect();
}

void draw(){
}