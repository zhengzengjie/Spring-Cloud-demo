<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/bootstrap/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">用户列表</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>name</th>
							<th>age</th>
							<th>sex</th>
						</tr>
					</thead>
					<tbody id="tcontent">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">用户列表1</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>name</th>
							<th>age</th>
							<th>sex</th>
						</tr>
					</thead>
					<tbody id="tcontent1">

					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$(function() {
		$.post("/user/queryAll", {}, function(d) {
			var html = '';
			if (d) {
				html += '';
				$.each(d, function(i, v) {
					html += '<tr><td>' + v.name + '</td><td>' + v.age
							+ '</td><td>' + v.sex + '</td></tr>';
				});
			} else {
				html = '<tr><td colspan="3">no record!</td></tr>';
			}
			$('#tcontent').html(html);
		});
		$.post("/user/queryAll1", {}, function(d) {
			var html = '';
			if (d) {
				html += '';
				$.each(d, function(i, v) {
					html += '<tr><td>' + v.name + '</td><td>' + v.age
							+ '</td><td>' + v.sex + '</td></tr>';
				});
			} else {
				html = '<tr><td colspan="3">no record!</td></tr>';
			}
			$('#tcontent1').html(html);
		});
	});
</script>