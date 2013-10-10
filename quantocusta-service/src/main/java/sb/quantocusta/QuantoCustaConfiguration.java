package sb.quantocusta;

import com.yammer.dropwizard.config.Configuration;

public class QuantoCustaConfiguration extends Configuration {
	
	private MongoConfiguration mongo;
	
	public MongoConfiguration getMongo() {
		return mongo;
	}
	
	public void setMongo(MongoConfiguration mongo) {
		this.mongo = mongo;
	}

}
