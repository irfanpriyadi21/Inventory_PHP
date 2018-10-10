<?php
session_start();
if(empty($_SESSION)){
  header("Location: login.php");
}
?>
<?php
  //error_reporting(0);

  include "koneksi.php";
  include "oop.php";

  $perintah = new oop;
  $table = "item";
  $form = "barangb.php";
  $autokode = $perintah->autokode($koneksi,$table,"id","I");

  $isi = '';

  $where = '';
  if(isset($_GET['hapus']) || isset($_GET['edit']) || isset($_POST['ubah'])){
    $where = "id = '$_GET[id]'";
  }

  if(isset($_GET['hapus'])){
    $data = $perintah->edit($koneksi, $table, $where);
    if(is_file("assets/img/".$data['image'])) // Jika foto ada
    unlink("assets/img/".$data['image']); // Hapus foto yang telah diupload dari folder images
    $perintah->hapus($koneksi, $table, $where, $form);
  }

  if(isset($_GET['edit'])){
    $edit = $perintah->edit($koneksi, $table, $where);
  }

  if(isset($_POST['ubah'])){
    $data = $perintah->edit($koneksi, $table, $where);

    $fotobaru = $data['image'];

    if(!empty($_FILES['image']['name'])){
      if(is_file("assets/img/".$data['image'])) // Jika foto ada
      unlink("assets/img/".$data['image']);

      $image = $_FILES['image']['name'];
      $tmp = $_FILES['image']['tmp_name'];
        
      // Rename nama fotonya dengan menambahkan tanggal dan jam upload
      $fotobaru = date('dmYHis').$image;
      // Set path folder tempat menyimpan fotonya
      $path = "assets/img/".$fotobaru;

      if(!move_uploaded_file($tmp, $path)){ 
        //ini kalo gagal upload -.-
      }
    }

    $isi = "id = '$_POST[kode]', name = '$_POST[name]', merk = '$_POST[merk]', description = '$_POST[description]', image = '".$fotobaru."', quantity = '$_POST[quantity]'";
  
    
      $perintah->ubah($koneksi, $table, $isi, $where, $form);

    
    
  }
  

if(isset($_POST['simpan'])){

  $image = $_FILES['image']['name'];
  $tmp = $_FILES['image']['tmp_name'];
    
  // Rename nama fotonya dengan menambahkan tanggal dan jam upload
  $fotobaru = date('dmYHis').$image;
  // Set path folder tempat menyimpan fotonya
  $path = "assets/img/".$fotobaru;

  $isi = "('$_POST[kode]','$_POST[name]','$_POST[merk]','$_POST[description]','".$fotobaru."','$_POST[quantity]')";

  if(move_uploaded_file($tmp, $path)){ // Cek apakah gambar berhasil diupload atau tidak
    // Proses simpan ke Database
    $perintah->simpan($koneksi, $table, $isi, $form);
  }else{
    // Jika gambar gagal diupload, Lakukan :
   echo "<script>alert('Gambar gagal diupload');document.location.href='$form'</script>";
  }
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

    <title>Barang</title>

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
                      <a href="admins.php">
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>

                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-desktop"></i>
                          <span>Transaksi</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="Peminjaman.php">Peminjaman</a></li>
                          <li><a  href="Pengembalian.php">Pengembalian</a></li>
                      </ul>
                  </li>

                  <li class="sub-menu">
                      <a class="active" href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Barang</span>
                      </a>
                      <ul class="sub">
                          <li  class="active"><a  href="barang.php">Data Barang</a></li>
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
          <h3><i class="fa fa-angle-right"></i> Data Barang</h3>

          <div class="row mt">
            <div class="col-lg-12">
              <div class="form-panel">
                <?php if(!isset($_GET['edit'])){ ?>
                <h4 class="mb"><i class="fa fa-angle-right"></i> Input Data Barang</h4>
                <form class="form-horizontal style-form" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Kode Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="kode" id="kode"  value="<?php echo $autokode; ?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="name" id="name" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Merek Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="merk" id="merk" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Deskripsi</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="description" id="description" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Foto</label>
                        <div class="col-sm-10">
                           <input name="image" type="file" class="form-control" size="30" maxlength="30">
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Stok</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="quantity" id="quantity" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                          <button type="submit" name="simpan" class="btn btn-theme">SIMPAN</button>
                        </div>
                  </div>
                </form>
                <?php }else{ ?>
                <h4 class="mb"><i class="fa fa-angle-right"></i> EDIT Data Barang</h4>
                <form class="form-horizontal style-form" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Kode Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="kode" id="kode"  value="<?php echo $edit['id']?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="name" id="name" value="<?php echo $edit['name']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Merek Barang</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="merk" id="merk" value="<?php echo $edit['merk']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Deskripsi</label>
                        <div class="col-sm-10">
                           <input type="comment" class="form-control" name="description" id="description" value="<?php echo $edit['description']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Foto</label>
                        <div class="col-sm-10">
                           <input type="file" class="form-control" name="image" size="30" maxlength="30" value="<?php echo $edit['image']?>" >
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Stok</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="quantity" id="quantity" value="<?php echo $edit['quantity']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                          <button type="submit" class="btn btn-theme" name="ubah">EDIT</button>
                        </div>
                  </div>
                </form>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="row mt">
            <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Laporan Data Barang</h4>
              <section id="unseen">
                <table id="tbbrg" class="table table-bordered table-striped table-condensed">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>Nama</th>
                      <th>Merek</th>
                      <th>Deskirpsi</th>
                      <th>Foto</th>
                      <th>Stok</th>
                      <th colspan="2">Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $query = "SELECT * FROM item"; // Query untuk menampilkan semua data siswa
                    $sql = mysqli_query($koneksi, $query); // Eksekusi/Jalankan query dari variabel $query
                    $no = 0;

                    while($data = mysqli_fetch_array($sql)){ 
                    // Ambil semua data dari hasil eksekusi $sql
                      $no++;
                      echo "<tr>";
                      echo "<td>".$no."</td>";
                      echo "<td>".$data['id']."</td>";
                      echo "<td>".$data['name']."</td>";
                      echo "<td>".$data['merk']."</td>";
                      echo "<td>".$data['description']."</td>";                      
                      echo "<td><img src='assets/img/".$data['image']."' width='100' height='100'></td>";
                      echo "<td>".$data['quantity']."</td>";
                    ?>
                      <td><a onclick="return confirm('Yakin mau dihapus?')" href="?hapus&id=<?php echo $data['id'] ?>">HAPUS</a></td>
                      <td><a href="?edit&id=<?php echo $data['id'] ?>">EDIT</a></td>
                      </tr>
                    <?php } ?>
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
              <a href="barangb.php#" class="go-top">
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