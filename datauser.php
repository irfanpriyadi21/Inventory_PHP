<?php

session_start();
if(empty($_SESSION)){
  header("Location: login.php");
}?>

<?php
// error_reporting(0);

include "koneksi.php";
include "oop.php";

$perintah = new oop();

$table = "user";
$form = "datauser.php";
$autokode = $perintah->autokode($koneksi,$table,"id","U");

$isi = '';
if(isset($_POST['simpan'])){
  //sesuaikan urutan field sesuai table
  $isi = "('$_POST[kode]','$_POST[name]', '$_POST[nohp]','$_POST[username]',
  '$_POST[password]','$_POST[level]')";
}

if(isset($_POST['ubah'])){
  //sesuaikan urutan field sesuai table
  $isi = "id = '$_POST[kode]', name =  '$_POST[name]', nohp = '$_POST[nohp]', username ='$_POST[username]', password = '$_POST[password]', level = '$_POST[level]'";
}

$where = '';
if(isset($_GET['hapus']) || isset($_GET['edit']) || isset($_POST['ubah'])){
  $where = "id = '$_GET[id]'";
}

if(isset($_POST['simpan'])){
  $perintah->simpan($koneksi, $table, $isi, $form);
}

if(isset($_GET['hapus'])){
  $perintah->hapus($koneksi, $table, $where, $form);
}

if(isset($_GET['edit'])){
  $edit = $perintah->edit($koneksi, $table, $where);
}

if(isset($_POST['ubah'])){
  $perintah->ubah($koneksi, $table, $isi, $where, $form);
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

    <title>Data User</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
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
                      <a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Barang</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="barang.php">Data Barang</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                      <a class="active" href="javascript:;" >
                          <i class=" fa fa-bar-chart-o"></i>
                          <span>User</span>
                      </a>
                      <ul class="sub">
                          <li  class="active"><a  href="datauser.php">Data User</a></li>
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
          <h3><i class="fa fa-angle-right"></i> Data User</h3>

          <div class="row mt">
            <div class="col-lg-12">
              <div class="form-panel">
                <?php if(!isset($_GET['edit'])){ ?>
                <h4 class="mb"><i class="fa fa-angle-right"></i> Input Data User</h4>
                <form class="form-horizontal style-form" method="post">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Kode User</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="kode" id="kode"  value="<?php echo $autokode; ?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="name" id="name"  required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">No HP</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="nohp" id="nohp"  required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Username</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="username" id="username"  required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="password" id="password"  required>
                        </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 col-sm-2 control-label">Level</label>
                    <div class="col-sm-10">
                      <select class="form-control" name="level">
                        <option value="Admin S">Admin S</option>
                        <option value="Admin B">Admin</option>
                        <option value="Master">Master</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                            <button type="submit" class="btn btn-theme" name="simpan">SIMPAN</button>
                        </div>
                  </div>
                </form>
                <?php }else{ ?>
                <h4 class="mb"><i class="fa fa-angle-right"></i> Edit Data User</h4>
                <form class="form-horizontal style-form" method="post">
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Kode User</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="kode" id="kode" value="<?php echo $edit['id']?>" readonly>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nama</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="name" id="name" value="<?php echo $edit['name']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Nomor Handphone</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="nohp" id="nohp" value="<?php echo $edit['nohp']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Username</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="username" id="username" value="<?php echo $edit['username']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-2 col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                           <input type="text" class="form-control" name="password" id="password" value="<?php echo $edit['password']?>" required>
                        </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 col-sm-2 control-label">Level</label>
                    <div class="col-sm-10">
                      <select class="form-control" name="level">
                        <option value="<?php echo $edit['level']?>"><?php echo $edit['level'] ?></option>
                        <option value="Admin S">Admin S</option>
                        <option value="Admin B">Admin</option>
                        <option value="Master">Master</option>
                      </select>
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
              <h4 class="mb"><i class="fa fa-angle-right"></i> Laporan Data User</h4>
              <section id="unseen">
                <table id="tbuser" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>Nama</th>
                      <th>No HP</th>
                      <th>Username</th>
                      <th>Password</th>
                      <th>Level</th>
                      <th colspan="2">Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php
                    $tampil = $perintah->tampil($koneksi, $table);
                    $no = 0;
                    foreach ($tampil as $field) {
                    $no++
                    ?>
                  <tr>
                      <td><?php echo $no; ?></td>
                      <td><?php echo $field['id']; ?></td>
                      <td><?php echo $field['name']; ?></td>
                      <td class="numeric"><?php echo $field['nohp']; ?></td>
                      <td><?php echo $field['username']; ?></td>
                      <td><?php echo $field['password']; ?></td>
                      <td><?php echo $field['level']; ?></td>
                      <td><a onclick="return confirm('Yakin mau dihapus?')" href="?hapus&id=<?php echo $field['id'] ?>">HAPUS</a></td>
                      <td><a href="?edit&id=<?php echo $field['id'] ?>">EDIT</a></td>
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
              <a href="datauser.php#" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
  </section>
  <script src="assets/js/jquery-1.12.4.js"></script>

  <script type="text/javascript">
    $(document).ready(function(){
      $('#tbuser').DataTable();
    });
  </script>

  <script src="assets/js/jquery.dataTables.min.js"></script>
  <script src="assets/js/dataTables.bootstrap4.min.js"></script>

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
