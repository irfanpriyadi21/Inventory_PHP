<?php
session_start();
include "koneksi.php";
include "oop.php";

$perintah = new oop();
?>
<!DOCTYPE html>
<html>
<head>
	<title>Laporan Peminjaman</title>
	<style type="text/css">
	#customers {
    	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    	border-collapse: collapse;
    	width: 100%;
	}

	#customers td, #customers th {
		border: 1px solid #ddd;
    	padding: 8px;
	}

	#customers tr:nth-child(even){background-color: #f2f2f2;}

	#customers tr:hover {background-color: #ddd;}

	#customers th {
    	padding-top: 12px;
    	padding-bottom: 12px;
    	text-align: left;
    	background-color: #4CAF50;
    	color: white;
	}
	h1{
		text-align: center;
		font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	}
	</style>
</head>
<body>
	<h1>Inventarisasi Alat Multimedia
		<br>
		SMK Wikrama Bogor
	</h1>
	<hr>
	<h1>Laporan Peminjaman</h1>
	<table id="customers">
		 <thead>
            <tr>
                <th>NO</th>
                <th>KODE</th>
                <th>KODE DETAIL</th>
                <th>TANGGAL</th>
                <th>NIS</th>
                <th>NAMA SISWA</th>
                <th>NAMA BARANG</th>
                <th>BANYAK</th>
                <th>KETERANGAN</th>
            </tr>
         </thead>
         <tbody>
        <?php
        if (empty($_SESSION['tgl1'])) {
        }else{
            $where = " where date BETWEEN '$_SESSION[tgl1]' and '$_SESSION[tgl2]'";
        }
        $tampil = $perintah->tampil($koneksi, "peminjaman".@$where);
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
                <td><?php echo $field['transaction_id']; ?></td>
                <td><?php echo $field['id']; ?></td>
                <td><?php echo $field['date']; ?></td>
                <td><?php echo $field['nis']; ?></td>
                <td><?php echo $field['nama']; ?></td>
                <td><?php echo $field['name']; ?></td>
                <td><?php echo $field['quantity']; ?></td>
                <td><?php echo $field['note']; ?></td>
            </tr>
        <?php }} ?>
         </tbody>
	</table>
</body>
</html>
<?php 
$_SESSION['tgl1'] = "";
$_SESSION['tgl2'] = "";
 ?>
<script>
	window.print();
</script>