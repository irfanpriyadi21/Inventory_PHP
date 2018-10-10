<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Inventarisasi Alat Multimedia</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/js/fancybox/jquery.fancybox.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">

    <script src="assets/js/jquery.js"></script>

    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
    .jumbotron{
    	background-image: url(assets/img/gambar1.jpg);
    	min-height: 600px;
    	text-align: center;
    	padding-top: 10%;
    	color: white; 
    }
    .pika{
      padding-left: 15px;
      padding-right: 15px;
    }
    .pica{
      background: #ffd777;
      border-bottom: 1px solid #c9aa5f;
      min-height: 80px;
    }
    </style>
  </head>

  <body>

  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
            <!--logo start-->
            <a href="index.html" class="logo"><b>Inventarisasi Alat Multimedia</b></a>
            <!--logo end-->
            <div class="top-menu">
            	<ul class="nav pull-right top-menu">
                    <li><a href="index.php" class="logo"><b>Home</b></a></li>
                    <li><a href="daftarbr.php" class="logo"><b>Daftar Barang</b></a></li>
                    <li><a href="surat.php" class="logo"><b>Surat Peminjaman</b></a></li>
                    <li><a href="login.html" class="logo"><b>Login</b></a></li>
            	</ul>
            </div>
        </header>
      <!--header end-->
		<div class="jumbotron">
		  <br>
		  <br>
		  <br>
		  <h1 class="display-4">Hello, world!</h1>
		  <p class="lead">Selamat datang di website inventarisasi alat multimedia!</p>
		  <hr class="my-4">
		  <p>MULTIMEDIA SMK WIKRAMA BOGOR</p>
		</div>
    <section class="pika">
      <h1 class="display-4">Gallery!</h1>
      <hr>
      <div class="row mt">
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 desc">
          <div class="project-wrapper">
            <div class="project">
              <div class="photo-wrapper">
                <div class="photo">
                  <a class="fancybox" href="assets/img/portfolio/port04.jpg"><img class="img-responsive" src="assets/img/portfolio/port04.jpg" alt=""></a>
                </div>
                <div class="overlay"></div>
              </div>
            </div>
          </div>
        </div><!-- col-lg-4 -->
          
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 desc">
          <div class="project-wrapper">
            <div class="project">
              <div class="photo-wrapper">
                <div class="photo">
                  <a class="fancybox" href="assets/img/portfolio/port05.jpg"><img class="img-responsive" src="assets/img/portfolio/port05.jpg" alt=""></a>
                </div>
                <div class="overlay"></div>
              </div>
            </div>
          </div>
        </div><!-- col-lg-4 -->
        
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 desc">
          <div class="project-wrapper">
            <div class="project">
              <div class="photo-wrapper">
                <div class="photo">
                  <a class="fancybox" href="assets/img/portfolio/port06.jpg"><img class="img-responsive" src="assets/img/portfolio/port06.jpg" alt=""></a>
                </div>
                <div class="overlay"></div>
              </div>
             </div>
          </div>
        </div><!-- col-lg-4 -->
      </div><!-- /row -->
    </section>
    <br>
    <div class="pica">
      <div class="row mt">
        <div class="col-lg-4">
      
        </div><!-- col-lg-4 -->
          
        <div class="col-lg-4">
         
        </div><!-- col-lg-4 -->
        
        <div class="col-lg-4">
         
        </div><!-- col-lg-4 -->
      </div><!-- /row -->
    </div>

  	</section>

  <!-- js placed at the end of the document so the pages load faster -->
  <script src="assets/js/fancybox/jquery.fancybox.js"></script>    
    <script src="assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="assets/js/jquery.scrollTo.min.js"></script>
    <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>


    <!--common script for all pages-->
    <script src="assets/js/common-scripts.js"></script>

    <!--script for this page-->
  
  <script type="text/javascript">
      $(function() {
        //    fancybox
          jQuery(".fancybox").fancybox();
      });

  </script>
  
  <script>
      //custom select box

      $(function(){
          $("select.styled").customSelect();
      });

  </script>

  </body>s
</html>
