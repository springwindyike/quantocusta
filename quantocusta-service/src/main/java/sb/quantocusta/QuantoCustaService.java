package sb.quantocusta;

import java.net.UnknownHostException;
import java.util.concurrent.TimeUnit;

import org.mongojack.JacksonDBCollection;

import sb.quantocusta.api.Venue;
import sb.quantocusta.health.MongoHealthCheck;
import sb.quantocusta.resources.ApiVenueResource;
import sb.quantocusta.resources.ApiVoteResource;
import sb.quantocusta.resources.Apis;
import sb.quantocusta.resources.GibaResource;
import sb.quantocusta.resources.HtmlResource;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.assets.AssetsBundle;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Environment;
import com.yammer.dropwizard.views.ViewBundle;

/**
 * 
 * @author giuliano.griffante
 *
 */
public class QuantoCustaService extends Service<QuantoCustaConfiguration> {

	private QuantoCustaConfiguration configuration;

	public QuantoCustaService() {

	}

	public void initialize(Bootstrap<QuantoCustaConfiguration> bootstrap) {
		bootstrap.setName("quantocusta-app");
		bootstrap.addBundle(new ViewBundle());

		bootstrap.addBundle(new AssetsBundle());

		//		bootstrap.addBundle(new AssetsBundle("/assets"));
		//		bootstrap.addBundle(new AssetsBundle("/views"));
	}

	public void run(QuantoCustaConfiguration configuration, Environment environment) {
		this.configuration = configuration;

		System.out.println(configuration);
		System.out.println(configuration.getMongo());
		System.out.println(configuration.getMongo().getDb());

		/* Health checkers */
		environment.addHealthCheck(new MongoHealthCheck(null));

		/* Cache */
		Cache<String, Object> venues = CacheBuilder.newBuilder()
				.maximumSize(1000)
				.expireAfterWrite(10, TimeUnit.MINUTES)
				.build();

		/* MongoDB */
		JacksonDBCollection<Venue, String> venuesColl = null;
		
		DB db = null;
		try {
			MongoClient client = new MongoClient(configuration.getMongo().getHost(), configuration.getMongo().getPort());
			db = client.getDB(configuration.getMongo().getDb());
			
			MongoManaged mongoManaged = new MongoManaged(client);
			environment.manage(mongoManaged);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		
		Apis.addApi("venue", new ApiVenueResource(db));
		Apis.addApi("vote", new ApiVoteResource(db));
		
		/* Resources */
		environment.addResource(Apis.get("venue"));
		environment.addResource(Apis.get("vote"));
		
		environment.addResource(new HtmlResource());
		environment.addResource(new GibaResource());
		
//		environment.addProvider(new OAuthProvider<User>(new ExampleAuthenticator(),
//                "SUPER SECRET STUFF"));
		
	}

	public static void main(String[] args) throws Exception {
		new QuantoCustaService().run(args);
		//		new QuantoCustaService().run(null, new String[]{"server", "src/main/resources/config.yaml"});
	}

}
