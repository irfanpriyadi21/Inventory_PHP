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
$form = "Peminjaman.php";
$autokode = $perintah->autokode($koneksi,"transaction","id","TR");
$autokode2 = $perintah->autokode($koneksi,"detail_temp","id","DT");
$autokode3 = $perintah->autokode($koneksi,"detail","id","D");

$isi = '';
$isi2 = '';

// if(isset($_POST['simpan'])){
//   $tanggal = date('Y-m-d');
//   $userid = $_SESSION['id'];
//   $nis = $_GET['nis']; 
//   //sesuaikan urutan field sesuai table
//   $isi = "('$_POST[kode]', '$nis', '$userid','$tanggal','$_POST[date_return]')";
//   //ini buat ngecek
//   // echo $isi;
//   // exit();
// }

$where = '';
$where2 = '';
if(isset($_GET['hapus'])){ 
  $where = "id='$_GET[id]'";
  $where2 = "transaction_id = '$_GET[id]'";
}

if(isset($_GET['cari'])){
  $cari = $perintah->edit($koneksi, "siswa", "nis = '$_GET[nis]'");
}

if(isset($_POST['pilbar'])){
  $item_id = $_POST['item_id'];

  $whe = "item_id = '$_POST[item_id]'";

  $cek = $perintah->edit($koneksi, "item", "id = '$_POST[item_id]'");
  $cekk = $cek['quantity'];

  $cak = $perintah->edit($koneksi, "detail_temp", "item_id = '$_POST[item_id]'");
  $cakkk = $cak['item_id'];
  $cakk = $cak['quantity'];

    $banyak = $_POST['quantity'];
    $blabla = $cakk + $banyak;

  if ($_POST['quantity'] < 1) {
    echo "<script>alert('Mohon masukkan data yang sesuai.');document.location.href='$form'</script>";
  }elseif ($_POST['quantity'] > 3) {
    echo "<script>alert('Peminjaman tidak boleh lebih dari 3 barang.');document.location.href='$form'</script>";
  }elseif($cekk < $_POST['quantity']){
    echo "<script>alert('Peminjaman melebihi stok yang ada.');document.location.href='$form'</script>";
  }elseif($cakkk == $item_id){
    $isiii = "quantity = $blabla";
    $perintah->ubah($koneksi, "detail_temp", $isiii, $whe, $form);
  }else{
  $isii = "('$_POST[detail_id]', '$autokode', '$_POST[item_id]', '$_POST[quantity]', 'DIPINJAM')";
  $perintah->simpan($koneksi, "detail_temp", $isii, $form);
  }
}

if(isset($_POST['simpan'])){
  if (empty($_GET['nis'])) {
    echo "<script>alert('Data belum lengkap!');document.location.href='$form'</script>";
  }else{
  $tanggal = date('Y-m-d');
  $userid = $_SESSION['id'];
  $nis = $_GET['nis']; 
  //sesuaikan urutan field sesuai table
  $isi = "('$_POST[kode]', '$nis', '$userid','$tanggal','$_POST[date_return]')";

  $wheree = "transaction_id = '$_POST[kode]'";
  $sql = "INSERT INTO detail SELECT '$autokode3', id, transaction_id, item_id, quantity, note FROM detail_temp WHERE transaction_id = '$_POST[kode]'";
  // echo $sql;
  // exit();
  $query = mysqli_query($koneksi, $sql);

    if($query){
      echo "<script>alert('Data berhasil disimpan');document.location.href='$form'</script>";
    }else{
      echo "<script>alert('Data gagal disimpan');document.location.href='$form'</script>";
    }
  $perintah->hapus($koneksi, "detail_temp", $wheree, $form);
  $perintah->simpan($koneksi, "transaction", $isi, $form);
  }
}

if(isset($_GET['hapusbarang'])){
  $wheree = "id = '$_GET[detail]'";
  $perintah->hapus($koneksi, "detail_temp", $wheree, $form);
}

if(isset($_GET['hapus'])){
  $perintah->hapus($koneksi, "transaction_return", $where2, $form);
  $perintah->hapus($koneksi, "detail", $where2, $form);
}

if(isset($_GET['hapus'])){
  $perintah->hapus($koneksi, "transaction", $where, $form);
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

    <title>Peminjaman</title>

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
            <a href="admins.php" class="logo"><b>Inventarisasi Alat Multimedia SMK WIKRAMA BOGOR</b></a>
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
                      <a href="admins.php">
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
                          <li class="active"><a  href="Peminjaman.php">Peminjaman</a></li>
                          <li><a  href="Pengembalian.php">Pengembalian</a></li>
                      </ul>
                  </li>

                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Barang</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="barang.php">Data Barang</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class=" fa fa-bar-chart-o"></i>
                          <span>User</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="datauser.php">Data User</a></li>
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
          <h3><i class="fa fa-angle-right"></i> Peminjaman</h3>
        <div class="row mt">
          <div class="col-lg-6">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Pilih Barang</h4>
              <form class="form-horizontal style-form" method="post">
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">Kode Detail</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="detail_id" id="detail_id" value="<?php echo $autokode2; ?>" readonly>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">Nama Barang</label>
                  <div class="col-sm-10">
                    <select name="item_id" class="form-control" required>
                      <?php  
                      $a = $perintah->tampill($koneksi, "item", "quantity != '0'");
                      foreach ($a as $b) {?>
                      <option value="<?= $b['0'] ?>"><?= $b['1'] ?></option>
                      <?php } ?>
                    </select>
                  </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 col-sm-2 control-label">Banyak Barang</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="quantity" id="quantity" value="1" required>
                    </div>
                    <div class="col-sm-5">
                      <button type="submit" class="btn btn-theme" name="pilbar" id="pilbar">Pilih Barang</button>
                    </div>
                  </div>
              </form>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Barang yang dipilih</h4>
              <section id="unseen">
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>Id Barang</th>
                      <th>Banyak Barang</th>
                      <th>Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampil($koneksi, "detail_temp");
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
                      <td><?php echo $field['item_id']; ?></td>
                      <td><?php echo $field['quantity']; ?></td>
                      <td><a class="btn btn-theme04" onclick="return confirm('Yakin mau dihapus?')" href="?hapusbarang&detail=<?php echo $field['id'] ?>"><i class="fa fa-times"></i> HAPUS</a></td>
                  </tr>
                    <?php }} ?>
                  </tbody>
              </table>
              </section>
            </div>
          </div>
        </div>
          <div class="row mt">
            <div class="col-lg-6">
              <div class="form-panel">
                <h4 class="mb"><i class="fa fa-angle-right"></i> Pilih Siswa</h4>
                <form class="form-horizontal style-form" method="get">
                  <?php if(isset($_GET['cari'])){ ?>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">NIS</label>
                        <div class="col-sm-5">
                           <input type="text" class="form-control" name="nis" id="nis" value="<?php echo $cari['nis']?>" required>
                        </div>
                        <div class="col-sm-5">
                           <button type="submit" class="btn btn-theme" name="cari" id="cari">Cari Siswa</button>                     
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="nama" id="nama" value="<?php echo $cari['nama']?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Rombel</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="rombel" id="rombel" value="<?php echo $cari['rombel']?>" readonly>
                        </div>
                  </div>
                  <?php }else{ ?>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">NIS</label>
                        <div class="col-sm-5">
                           <input type="text" class="form-control" name="nis" id="nis" required>
                        </div>
                        <div class="col-sm-5">
                           <button type="submit" class="btn btn-theme" name="cari" id="cari">Cari Siswa</button>                     
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="nama" id="nama" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Rombel</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="rombel" id="rombel" readonly>
                        </div>
                  </div>
                  <?php } ?>
                </form>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="form-panel">
                <h4 class="mb"><i class="fa fa-angle-right"></i> Input Peminjaman</h4>
                <form class="form-horizontal style-form" method="post">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Peminjaman</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="kode" id="kode"  value="<?php echo $autokode; ?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Tanggal Kembali</label>
                        <div class="col-sm-10">
                           <input type="date" class="form-control" name="date_return" required>
                        </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-12">
                      <button type="submit" class="btn btn-primary btn-lg btn-block" name="simpan" id="simpan"><i class="fa fa-check"></i> SIMPAN PEMINJAMAN</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        <div class="row mt">
            <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Laporan Peminjaman</h4>
              <section id="unseen">
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>NIS</th>
                      <th>ID User</th>
                      <th>Tanggal</th>
                      <th>Pengembalian</th>
                      <th colspan="2">Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampil($koneksi, "transaction");
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
                      <td><?php echo $field['user_id']; ?></td>
                      <td><?php echo $field['date']; ?></td>
                      <td><?php echo $field['date_return']; ?></td>
                      <td><a class="btn btn-theme04" onclick="return confirm('Yakin mau dihapus?')" href="?hapus&id=<?php echo $field['id'] ?>"><i class="fa fa-times"></i> HAPUS</a></td>
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
              <a href="Peminjaman.php#" class="go-top">
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
