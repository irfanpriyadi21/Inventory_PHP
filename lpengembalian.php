<?php
session_start();
if(empty($_SESSION)){
  header("Location: login.php");
}
?>
<?php
//mengatur zona waktu agar sesuai dengan waktu lokal
  date_default_timezone_set("Asia/Jakarta");

include "koneksi.php";
include "oop.php";

$perintah = new oop();
$form = "lpeminjaman.php";
$table = "peminjaman";

?>
<!DOCTYPE html>
<form method="post">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Laporan Peminjaman</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="assets/css/zabuto_calendar.css">
    <link rel="stylesheet" type="text/css" href="assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="assets/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">

    <script src="assets/js/chart-master/Chart.js"></script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="master.php" class="logo"><b>Inventarisasi Alat Multimedia SMK WIKRAMA BOGOR</b></a>
            <!--logo end-->
            <div class="top-menu">
              <ul class="nav pull-right top-menu">
                    <li><a class="logout" href="logout.php" onclick="return confirm('Yakin ingin Logout?')">Logout</a></li>
              </ul>
            </div>
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
                  <p class="centered"><a href="profile.html"><img src="assets/img/logo.jpg" class="img-circle" width="60"></a></p>
                  <h5 class="centered"><?php echo $_SESSION['username']; ?></h5>
                    
                  <li class="mt">
                      <a href="master.php">
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>

                  <li class="sub-menu">
                      <a href="javascript:;" class="active">
                          <i class="fa fa-desktop"></i>
                          <span>Laporan</span>
                      </a> 
                      <ul class="sub">
                          <li><a href="lpeminjaman.php">Peminjaman</a></li>
                          <li class="active"><a  href="lpengembalian.php">Pengembalian</a></li>
                          <li><a  href="lbarang.php">Barang</a></li>
                          <li><a  href="lpegawai.php">Pegawai</a></li>
                      </ul>
                  </li>
              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
        <section class="wrapper">
          <h3><i class="fa fa-angle-right"></i> Laporan Pengembalian</h3>
          <div class="row mt">
            <div class="col-lg-12">
            <div class="form-panel">
              <form class="form-horizontal style-form" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label" style="text-align: center; margin-top: 10px;">Pilih tanggal</label>
                        <div class="col-sm-3">
                           <input type="date" class="form-control" name="tgl1">
                        </div>
                        <div class="col-sm-3">
                           <input type="date" class="form-control" name="tgl2">
                        </div>
                        <div class="col-sm-4">
                           <input class="btn btn-info" type="submit" name="caritgl" value="CARI">
                           <a class="btn btn-success" href="lpengembalian.php">RESET</a>
                           <a class="btn btn-warning" href="laporankembali.php">CETAK LAPORAN</a>
                        </div>
                  </div>
              </form>
              <br>
              <?php 
              if (isset($_POST['caritgl'])) {
                if (empty($_POST['tgl1']) || empty($_POST['tgl2'])) {
                  echo "<script>alert('Silahkan Pilih Tanggal !')</script>";
                }else{
                  $where = " where date_return BETWEEN '$_POST[tgl1]' and '$_POST[tgl2]'";
                  $_SESSION['tgl1'] = $_POST['tgl1'];
                  $_SESSION['tgl2'] = $_POST['tgl2'];
                }
              }
              ?>
              <section id="unseen">
                <br>
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode Pengembalian</th>
                      <th>Kode Transaksi</th>
                      <th>NIS</th>
                      <th>Nama</th>
                      <th>Nama Barang</th>
                      <th>Banyak</th>
                      <th>Tanggal Kembali</th>
                      <th>Telat</th>
                      <th>Keterangan</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampil($koneksi, "lpengembalian".@$where);
                    $no = 0;
                    if (is_null($tampil)) {
                      echo "<tr>
                      <td colspan = '11'>Belum ada data</td>
                      </tr>";
                    }else{
                    foreach ($tampil as $field) {
                    $no++;
                    ?>
                  <tr>
                      <td><?php echo $no; ?></td>
                      <td><?php echo $field['id']; ?></td>
                      <td><?php echo $field['transaction_id']; ?></td>
                      <td><?php echo $field['nis']; ?></td>
                      <td><?php echo $field['nama']; ?></td>
                      <td><?php echo $field['name']; ?></td>
                      <td><?php echo $field['quantity']; ?></td>
                      <td><?php echo $field['date_return']; ?></td>
                      <td><?php echo $field['day_late']; ?></td>
                      <td><?php echo $field['note']; ?></td>
                  </tr>
                    <?php }} ?>
                  </tbody>
              </table>
              </section>
            </div>
            </div>
          </div>
        </section>
      </section>

      <!--main content end-->_
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
              <a href="lpengembalian.php#" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
  </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/jquery-1.8.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="assets/js/jquery.scrollTo.min.js"></script>
    <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="assets/js/jquery.sparkline.js"></script>


    <!--common script for all pages-->
    <script src="assets/js/common-scripts.js"></script>
    
    <script type="text/javascript" src="assets/js/gritter/js/jquery.gritter.js"></script>
    <script type="text/javascript" src="assets/js/gritter-conf.js"></script>
  </body>
</html>
</form>