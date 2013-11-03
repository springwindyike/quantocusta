<!DOCTYPE html>
<html lang="pt-BR">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="description" content="">
		<meta name="author" content="">

		<title>Quanto Custa?</title>
		
		<!-- Bootstrap core CSS -->
		<link href="/assets/css/bootstrap.css" rel="stylesheet">

		<!-- Add custom CSS here -->
		<link href="/assets/css/starving-3.css" rel="stylesheet">
		<link href="/assets/css/font-awesome.min.css" rel="stylesheet">
		<link href="/assets/css/whhg.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Raleway:400,200,300' rel='stylesheet' type='text/css'>
	</head>

	<body>
	
		<div class="container">
	
			<div class="panel panel-default">
				<div class="panel-body">
					<!-- img class="img img-responsive" src="http://placehold.it/480x320" -->
					<h1>${venue.name}</h1>
					<strong><#if venue.category??>${venue.category.name!""}</#if></strong>
					<address>
						<#if venue.address??><i class="fa fa-map-marker"></i> ${venue.address!""}<br></#if>
						<#if venue.site??><i class="fa fa-globe"></i> ${venue.site!""}<br></#if>
						<#if venue.phone??><i class="fa fa-phone"></i> ${venue.phone!""}</#if>
					</address>
					
					<div class="section-price">
						<span class="sign">R$</span>
						<div class="text-center"><span class="price"><#if venue.reviews.averagePrice &gt; 0>${venue.reviews.averagePrice?string("0")},00<#else>--</#if></span></div>
						<small class="info pull-right">por pessoa</small>
					</div>
					
					<div class="row">
						<div class="summary col-xs-4 text-center">
							<span class="markup markup-green"></span>
							Comida<br>
							<i class="icon-soup fa-lg"></i> <span class="val food">${venue.valuation.food.smileAverage?string("0")}%</span>
						</div>
						<div class="summary col-xs-4 text-center">
							<span class="markup markup-blue"></span>
							Atendimento<br>
							<i class="icon-foodtray fa-lg"></i> <span class="val treatment">${venue.valuation.treatment.smileAverage?string("0")}%</span>
						</div>
						<div class="summary col-xs-4 text-center">
							<span class="markup markup-yellow"></span>
							Ambiente<br>
							<i class="icon-store fa-lg"></i> <span class="val environment">${venue.valuation.environment.smileAverage?string("0")}%</span> 
						</div>
					</div>
				</div>
				
			</div>
			
			<div class="panel panel-primary">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-12">
							<form id="submitPrice" class="form-horizontal" role="form" action="/api/vote/price" method="post">
								<input type="hidden" name="where" value="${venue.id}">
								<div class="form-group col-xs-12 text-center">
									<span>J&aacute; fui e paguei</span>
								</div>
								<div class="form-group">
									<label class="col-xs-3 text-right" style="font-size: 32px;">R$</label>
									<input type="text" name="price" class="input-lg form-contol col-xs-6">
									<div class="col-xs-2"><button type="submit" class="btn btn-default btn-lg"><i class="icon-thumbs-up"></i></button></div>
								</div>
								<div class="form-group">
									<div class="col-xs-12 text-right">
										<small>por pessoa</small>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		
			<div class="row">
				<div class="col-xs-12">
					<h4>Avalie</h4>
					<div class="list-group">
						<div class="list-group-item">
							<i class="icon-soup fa-2x"></i> <span>Comida</span>
							<div class="btn-group pull-right">
								<button type="button" class="btn btn-info btn-food-s" onclick="qc.vote('${venue.id}', 'food', 1);"><i class="fa fa-smile-o fa-2x"></i></button>
								<button type="button" class="btn btn-info btn-food-p" onclick="qc.vote('${venue.id}', 'food', -1);"><i class="fa fa-frown-o fa-2x"></i></button>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="list-group-item">
							<i class="icon-foodtray fa-2x"></i> <span>Atendimento</span>
							<div class="btn-group pull-right">
								<button type="button" class="btn btn-info btn-treatment-s" onclick="qc.vote('${venue.id}', 'treatment', 1);"><i class="fa fa-smile-o fa-2x"></i></button>
								<button type="button" class="btn btn-info btn-treatment-p" onclick="qc.vote('${venue.id}', 'treatment', -1);"><i class="fa fa-frown-o fa-2x"></i></button>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="list-group-item">
							<i class="icon-store fa-2x"></i> <span>Ambiente</span>
							<div class="btn-group pull-right">
								<button type="button" class="btn btn-info btn-environment-s" onclick="qc.vote('${venue.id}', 'environment', 1);"><i class="fa fa-smile-o fa-2x"></i></button>
								<button type="button" class="btn btn-info btn-environment-p" onclick="qc.vote('${venue.id}', 'environment', -1);"><i class="fa fa-frown-o fa-2x"></i></button>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>		
	
				
			</div>
		
		</div>

		<#include "/assets/tpl/components/footer.ftl">

		<#include "/assets/tpl/components/scripts.ftl">
		<script type="text/javascript">
			$("#submitPrice").submit(function(event) {
				// Stop form from submitting normally
				event.preventDefault();
				
				// Get some values from elements on the page:
				var $form = $(this),
					where = $form.find( "input[name='where']" ).val(),
					price = $form.find( "input[name='price']" ).val(),
					url = $form.attr( "action" );
			 
				// Send the data using post
				qc.submitPrice(where, price);
			 
				// Put the results in a div
				//posting.done(function( data ) {
				//	var content = $( data ).find( "#content" );
				//	$( "#result" ).empty().append( content );
				//});
			});
		</script>
	</body>
</html>