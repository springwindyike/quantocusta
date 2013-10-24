package sb.quantocusta.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import sb.quantocusta.views.SimplePageView;

@Path("/search")
@Produces(MediaType.TEXT_HTML)
public class SearchResource {

	public SearchResource() {
	}
	
	@GET
	@Produces("text/html; charset=UTF-8")
	public SimplePageView search() {
		return new SimplePageView("/assets/search.ftl");
	}

//	@GET
//	@Path("json")
//	public Object json() {
//		return new String("coisa");
//	}
	
}
