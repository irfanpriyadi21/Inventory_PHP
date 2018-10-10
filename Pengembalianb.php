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
$form = "Pengembalianb.php";
$table = "transaction_return";
$autokode = $perintah->autokode($koneksi,"transaction_return","id","RE");

if(isset($_GET['kembali'])){
  $cek = $perintah->edit($koneksi, "transaction", "id = '$_GET[id]'");
  $cekk = $cek['date_return'];

  $tanggal = date('Y-m-d');
  $userid = $_SESSION['id'];
  $note = 'Dikembalikan oleh '.$userid;
  $where2 = "transaction_id = '$_GET[id]'";
  //daylate
  $tanggala = $cekk;
  $tanggalb = $tanggal;

  $date1=date_create($tanggala);
  $date2=date_create($tanggalb);
  // $daylate = $perintah->daylate($koneksi, $tanggala, $tanggalb, $form);
  $daylate = date_diff($date1,$date2);
  $daylate = $daylate->format('%a');

  $sql = "INSERT INTO transaction_return SELECT '$autokode', '$userid', transaction_id, item_id, quantity, '$tanggal', '$daylate', '$note' FROM detail WHERE transaction_id = '$_GET[id]' and note != 'SUDAH DIKEMBALIKAN'";
  // echo $sql;
  // exit();
  $query = mysqli_query($koneksi, $sql);
    if($query){
      echo "<script>alert('Data berhasil disimpan');document.location.href='$form'</script>";
    }else{
      echo "<script>alert('Data gagal disimpan');document.location.href='$form'</script>";
    }
  $perintah->ubah($koneksi, "detail",  "note = 'SUDAH DIKEMBALIKAN'", $where2, $form);
}

if(isset($_GET['kembalikan'])){
  $cek = $perintah->edit($koneksi, "transaction", "id = '$_GET[tr]'");
  $cekk = $cek['date_return'];

  $tanggal = date('Y-m-d');
  $userid = $_SESSION['id'];
  $note = 'Dikembalikan oleh '.$userid;
  $wheree = "item_id = '$_GET[itemid]' and transaction_id = '$_GET[tr]'";
  //daylate
  $tanggala = $cekk;
  $tanggalb = $tanggal;

  $date1=date_create($tanggala);
  $date2=date_create($tanggalb);
  // $daylate = $perintah->daylate($koneksi, $tanggala, $tanggalb, $form);
  $daylate = date_diff($date1,$date2);
  $daylate = $daylate->format('%a');

  $sql = "INSERT INTO transaction_return SELECT '$autokode', '$userid', transaction_id, item_id, quantity, '$tanggal', '$daylate', '$note' FROM detail WHERE transaction_id = '$_GET[tr]' and item_id = '$_GET[itemid]'";
  // echo $sql;
  // exit();
  $query = mysqli_query($koneksi, $sql);
    if($query){
      echo "<script>alert('Data berhasil disimpan');document.location.href='$form'</script>";
    }else{
      echo "<script>alert('Data gagal disimpan');document.location.href='$form'</script>";
    }
  $perintah->ubah($koneksi, "detail",  "note = 'SUDAH DIKEMBALIKAN'", $wheree, $form);
}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Pengembalian</title>

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
            <a href="adminb.php" class="logo"><b>Inventarisasi Alat Multimedia SMK WIKRAMA BOGOR</b></a>
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
                      <a href="adminb.php">
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>

                  <li class="sub-menu">
                      <a class="active" href="javascript:;" >
                          <i class="fa fa-desktop"></i>
                          <span>Transaksi</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="Peminjamanb.php">Peminjaman</a></li>
                          <li class="active"><a  href="Pengembalianb.php">Pengembalian</a></li>
                      </ul>
                  </li>

                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Barang</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="barangb.php">Data Barang</a></li>
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
          <h3><i class="fa fa-angle-right"></i> Pengembalian</h3>
          <div class="row mt">
            <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Pengembalian per-transaksi</h4>
              <section id="unseen">
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode Transaksi</th>
                      <th>NIS</th>
                      <th>Nama</th>
                      <th>Tanggal Pinjam</th>
                      <th>Tanggal Pengembalian</th>
                      <th colspan="2">Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampilll($koneksi, "pengembalianpertr", "note != 'SUDAH DIKEMBALIKAN'");
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
                      <td><?php echo $field['nis']; ?></td>
                      <td><?php echo $field['nama']; ?></td>
                      <td><?php echo $field['date']; ?></td>
                      <td><?php echo $field['date_return']; ?></td>
                      <td><a onclick="return confirm('Yakin akan dikembalikan?')" href="?kembali&id=<?php echo $field['id'] ?>">KEMBALIKAN</a></td>
                  </tr>
                    <?php }} ?>
                  </tbody>
              </table>
              </section>
            </div>
            </div>
          </div>
          <div class="row mt">
            <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Pengembalian per-barang</h4>
              <section id="unseen">
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>Kode Transaksi</th>
                      <th>Nis</th>
                      <th>Nama</th>
                      <th>Kode Barang</th>
                      <th>Nama Barang</th>
                      <th>Jumlah</th>
                      <th>Catatan</th>
                      <th colspan="2">Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampill($koneksi, 'pengembalian2', "note != 'SUDAH DIKEMBALIKAN'");
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
                      <td><?php echo $field['item_id']; ?></td>
                      <td><?php echo $field['name']; ?></td>
                      <td><?php echo $field['quantity']; ?></td>
                      <td><?php echo $field['note']; ?></td>
                      <td><a onclick="return confirm('Yakin akan dikembalikan?')" href="?kembalikan&id=<?php echo $field['id'] ?>&tr=<?php echo $field['transaction_id'] ?>&itemid=<?php echo $field['item_id'] ?>">KEMBALIKAN</a></td>             
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

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
              <a href="Pengembalianb.php#" class="go-top">
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
