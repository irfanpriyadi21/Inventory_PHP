<?php
include "koneksi.php";
include "oop.php";

$perintah = new oop();
?>
<!DOCTYPE html>
<html>
<head>
	<title>Laporan Barang</title>
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
	<h1>Laporan Barang</h1>
	<table id="customers">
		 <thead>
            <tr>
                <th>NO</th>
                <th>KODE</th>
                <th>NAMA</th>
                <th>MEREK</th>
                <th>DESKRIPSI</th>
                <th>GAMBAR</th>
                <th>STOK</th>
            </tr>
         </thead>
         <tbody>
        <?php
        $tampil = $perintah->tampil($koneksi, "item".@$where);
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
                <td><?php echo $field['name']; ?></td>
                <td><?php echo $field['merk']; ?></td>
                <td><?php echo $field['description']; ?></td>
                <?php echo "<td><img src='assets/img/".$field['image']."' width='100' height='100'></td>"; ?>
                <td><?php echo $field['quantity']; ?></td>
            </tr>
        <?php }} ?>
         </tbody>
	</table>
</body>
</html>
<script>
	window.print();
</script>