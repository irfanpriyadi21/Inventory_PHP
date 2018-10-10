<?php
session_start();
if($_SESSION){
	header("Location: login.php");
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login - Inventarisasi Alat Multimedia</title>
	<link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">
</head>
<body>
	<div id="login-page">
		<div class="container">
			<form class="form-login" method="post">
				<?php
				if(isset($_POST['login'])) {
					include("koneksi.php");

					$username = $_POST['username'];
					$password = $_POST['password'];
					$level = $_POST['level'];

					$query = mysqli_query($koneksi, "SELECT * FROM user WHERE username = '$username'
						AND password = '$password'");
					if (mysqli_num_rows($query) == 0) {
						echo "<script>alert('Pastikan data anda lengkap dan benar');document.location.href='login.php'</script>";
					}else{
						$row = mysqli_fetch_assoc($query);
						$_SESSION['id']=$row['id'];
						if($row['level'] == 'Master' && $level == 'Master'){
							$_SESSION['username']=$username;
							$_SESSION['level']='Master';
							header("Location: master.php");
						}elseif ($row['level'] == 'Admin S' && $level == 'Admin S') {
							$_SESSION['username']=$username;
							$_SESSION['level']='Admin S';
							header("Location: admins.php");
						}elseif ($row['level'] == 'Admin B' && $level == 'Admin B') {
							$_SESSION['username']=$username;
							$_SESSION['level']='Admin B';
							header("Location: adminb.php");
						}else{
							echo "<script>alert('Pastikan data anda lengkap dan benar');document.location.href='index.php'</script>";
						}
					}
				}
				if(isset($_POST['exit'])){
					echo "<script>alert('Kembali ke menu utama');document.location.href='index.php'</script>";
				}
				?>
		        <h2 class="form-login-heading">sign in now</h2>
		        <div class="login-wrap">
		            <input type="text" name="username" class="form-control" placeholder="User ID" autofocus>
		            <br>
		            <input type="password" name="password" class="form-control" placeholder="Password">
		            <br>
		            <select name="level" class="form-control">
						<option value="">Pilih Level User</option>
						<option value="Admin S">Admin S</option>
						<option value="Admin B">Admin B</option>
						<option value="Master">Master</option>
					</select>
					<br>
		            <button class="btn btn-theme btn-block" name="login" type="submit"><i class="fa fa-lock"></i> SIGN IN</button>
		            <br>
		            <button class="btn btn-theme btn-block" name="exit" type="submit" href="index.php">BATAL</button>
		            <hr>
		        </div>
			</form>
		</div>
	</div>

	<script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/js/jquery.backstretch.min.js"></script>
    <script>
        $.backstretch("assets/img/gambar2.jpg", {speed: 500});
    </script>

</body>
</html>