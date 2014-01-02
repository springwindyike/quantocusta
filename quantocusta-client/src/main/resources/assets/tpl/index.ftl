<!DOCTYPE html>
<html lang="pt-BR">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="description" content="">
		<meta name="author" content="">

		<title>Quanto Custa?</title>

		<!-- Bootstrap core CSS -->
		<link href="/assets/css/bootstrap.min.css" rel="stylesheet">

		<!-- Add custom CSS here -->
		<link href="/assets/css/starving-3.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Raleway:400,200,300' rel='stylesheet' type='text/css'>
	</head>

	<body>
	
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="container-bg">
						<img class="img img-responsive bg" width="320" src="../assets/images/logo.png">
						<div class="overlay">
							<h1 style="text-indent: -9999px;">Quanto Custa?</h1>
							<div class="hide">
								<span>Quer ir em um restaurante e saber quanto irá pagar?</span>
								<form class="form-search" action="/buscar">
									<input type="text" name="q" placeholder="Restaurantes, bares, cafés..." required>
									<button type="submit"><i class="icon-search"></i></button>
									<div class="clearfix"></div>
								</form>
							</div>
							<br><br>
							<div class="loading">
								<img alt="Carregando conteúdo..." src="../assets/images/ajax-loader-2.gif">
							</div>
						</div>
					</div>
					<div class="hide">
						<a href="https://www.facebook.com/dialog/oauth?client_id=479032988828474&redirect_uri=http://m.quantocusta.cc/auth/connect&scope=email,user_about_me,publish_actions&response_type=code" class="btn btn-link"><i class="icon-facebook"></i> Conecte-se com o Facebook</a>
					</div>
				</div>
			</div>
		</div>
	
		<#include "/assets/tpl/components/footer.ftl">

		<#include "/assets/tpl/components/scripts.ftl">
		<script>
			$(document).ready(function() {
				qc.loadCoordinates();
			});
		</script>
	</body>
</html>