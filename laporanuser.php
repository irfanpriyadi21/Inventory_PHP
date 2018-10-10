<?php
include "koneksi.php";
include "oop.php";

$perintah = new oop();
?>
<!DOCTYPE html>
<html>
<head>
	<title>Laporan User</title>
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
	<h1>Laporan User</h1>
	<table id="customers">
		 <thead>
            <tr>
                <th>NO</th>
                <th>KODE USER</th>
                <th>NAMA USER</th>
                <th>NOMOR HANDPHONE</th>
                <th>USERNAME</th>
                <th>PASSWORD</th>
                <th>JABATAN</th>
            </tr>
         </thead>
         <tbody>
        <?php
        $tampil = $perintah->tampil($koneksi, "user".@$where);
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
                <td><?php echo $field['nohp']; ?></td>
                <td><?php echo $field['username']; ?></td>
                <td><?php echo $field['password']; ?></td>
                <td><?php echo $field['level']; ?></td>
            </tr>
        <?php }} ?>
         </tbody>
	</table>
</body>
</html>
<script>
	window.print();
</script>