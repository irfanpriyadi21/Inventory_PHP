<?php 
include "koneksi.php";
include "oop.php";
$perintah = new oop();
?>

<!DOCTYPE html>
<html >
<head>
  <!-- Site made with Mobirise Website Builder v4.6.3, https://mobirise.com -->
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="Mobirise v4.6.3, mobirise.com">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
  <link rel="shortcut icon" href="assets2/images/kuya-512x512.png" type="image/x-icon">
  <meta name="description" content="Website Generator Description">
  <title>daftarbarang</title>
  <link rel="stylesheet" href="assets2/web/assets/mobirise-icons/mobirise-icons.css">
  <link rel="stylesheet" href="assets2/tether/tether.min.css">
  <link rel="stylesheet" href="assets2/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets2/bootstrap/css/bootstrap-grid.min.css">
  <link rel="stylesheet" href="assets2/bootstrap/css/bootstrap-reboot.min.css">
  <link rel="stylesheet" href="assets2/socicon/css/styles.css">
  <link rel="stylesheet" href="assets2/dropdown/css/style.css">
  <link rel="stylesheet" href="assets2/theme/css/style.css">
  <link rel="stylesheet" href="assets2/mobirise/css/mbr-additional.css" type="text/css">

  <link rel="stylesheet" type="text/css" href="assets/DataTables/css/jquery.dataTables.css">
  <link rel="stylesheet" type="text/css" href="assets/DataTables/css/dataTables.bootstrap.css">
  
  
</head>
<body>
<form method="post" enctype="multipart/form-data">
  <section class="menu cid-qM9JnUTXxQ" once="menu" id="menu1-1l">

    

    <nav class="navbar navbar-expand beta-menu navbar-dropdown align-items-center navbar-fixed-top navbar-toggleable-sm">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
        </button>
        <div class="menu-logo">
            <div class="navbar-brand">
                <span class="navbar-logo">
                    <a href="index.php">
                         <img src="assets2/images/logo.jpg" alt="Mobirise" title="" style="height: 3.8rem;">
                    </a>
                </span>
                <span class="navbar-caption-wrap">
                  <a class="navbar-caption text-white display-4" href="index.php">Inventarisasi Alat Multimedia</a>
                </span>
            </div>
        </div>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav nav-dropdown nav-right" data-app-modern-menu="true">
              <li class="nav-item">
                 <a class="nav-link link text-white display-4" href="index.php">
                   <span class="mbri-home mbr-iconfont mbr-iconfont-btn"></span>Home
                  </a>
              </li>
              <li class="nav-item">
                <a class="nav-link link text-white display-4" href="page1.php">
                  <span class="mbri-cart-add mbr-iconfont mbr-iconfont-btn"></span>Daftar Barang
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link link text-white display-4" href="page5.php">
                  <span class="mbri-letter mbr-iconfont mbr-iconfont-btn"></span>Form Peminjaman
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link link text-white display-4" href="login.php">
                  <span class="mbri-user mbr-iconfont mbr-iconfont-btn"></span>Login
                </a>
              </li>
            </ul>
            
        </div>
    </nav>
</section>

<section class="engine">
  <a href="https://mobirise.ws/l">html web maker</a>
</section>

<section class="features17 cid-qM30n1bUV1 mbr-parallax-background" id="features17-q">
    <div class="row row-sm-offset" align="center">
      <table id="tbbrg" class="table table-bordered table-striped table-responsive" cellspacing="0" width="95%">
        <thead>
                  <tr>
                      <th>No</th>
                      <th>Kode</th>
                      <th>Nama</th>
                      <th>Deskirpsi</th>
                      <th>Foto</th>
                      <th>Stok</th>
                    
                  </tr>
        </thead>
                  <tbody>
                    
                    <?php
                    $query = "SELECT * FROM item"; 
                    // Query untuk menampilkan semua data siswa
                    $sql = mysqli_query($koneksi, $query); // Eksekusi/Jalankan query dari variabel $query
                    $no = 0;

                    while($data = mysqli_fetch_array($sql)){ 
                    // Ambil semua data dari hasil eksekusi $sql
                      $no++;
                      echo "<tr>";
                      echo "<td>".$no."</td>";
                      echo "<td>".$data['id']."</td>";
                      echo "<td>".$data['name']."</td>";
                      echo "<td>".$data['description']."</td>";                      
                      echo "<td> <img src='../CBT_produktif/assets/img/".$data['image']."' width='100' height='100'></td>";
                      echo "<td>".$data['quantity']."</td>";
                    ?>
                     
                      </tr>
                    <?php } ?>
                  </tbody>
      </table>
    </div>
</section>

<section class="cid-qM30n3b0qE" id="footer1-r">
    <div class="container">
        <div class="media-container-row content text-white">
            <div class="col-12 col-md-3">
                <div class="media-wrap">
                    <a href="index.php">
                        <img src="assets2/images/logo.jpg" alt="Mobirise" title="">
                    </a>
                </div>
            </div>
            <div class="col-12 col-md-3 mbr-fonts-style display-7">
                <h5 class="pb-3">Address</h5>
                <p class="mbr-text">Jalan Raya Tajur - Bogor&nbsp;<br>16837876</p>
            </div>
            <div class="col-12 col-md-3 mbr-fonts-style display-7">
                <h5 class="pb-3">Contacts</h5>
                <p class="mbr-text">Email: Multimedia@gmail.com&nbsp;<br>Phone: 0821987654456<br><br></p>
            </div>
        </div>
        <div class="footer-lower">
            <div class="media-container-row">
                <div class="col-sm-12">
                    <hr>
                </div>
            </div>
            <div class="media-container-row mbr-white">
                <div class="col-sm-6 copyright">
                 <p class="mbr-text mbr-fonts-style display-7">© Copyright 2018 &nbsp;- All Rights Reserved</p>
                </div>
                <div class="col-md-6"> 
                </div>
            </div>
        </div>
    </div>
</section>
  

  <script src="assets2/web/assets/jquery/jquery.min.js"></script>
  <script src="assets2/popper/popper.min.js"></script>
  <script src="assets2/tether/tether.min.js"></script>
  <script src="assets2/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets2/dropdown/js/script.min.js"></script>
  <script src="assets2/touchswipe/jquery.touch-swipe.min.js"></script>
  <script src="assets2/parallax/jarallax.min.js"></script>
  <script src="assets2/smoothscroll/smooth-scroll.js"></script>
  <script src="assets2/theme/js/script.js"></script>
  <script type="text/javascript" src="assets/DataTables/js/jquery.dataTables.min.js"></script>
  <script type="text/javascript" src="assets/DataTables/js/jquery.dataTables.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
    $('#tbbrg').DataTable();
    } );
  </script>
</form>  
</body>
</html>