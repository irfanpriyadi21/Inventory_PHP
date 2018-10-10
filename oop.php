<?php
class oop {
	
	function simpan($koneksi, $table, $isi, $form){
		$sql = "INSERT INTO $table VALUES $isi";
		$query = mysqli_query($koneksi, $sql);
		if($query){
			echo "<script>alert('BERHASIL');document.location.href='$form'</script>";
		}else{
			echo "<script>alert('GAGAL');document.location.href='$form'</script>";
		}
	}

	function tampil($koneksi, $table){
		$sql = "SELECT * FROM $table";
		$query = mysqli_query($koneksi, $sql);
		if($query){
		while ($data = mysqli_fetch_array($query))
			$isi[] = $data;
		}
		return @$isi;
	}

	function tampilll($koneksi, $table, $where){
		$sql = "SELECT DISTINCT(id), nis, nama, date, date_return, note FROM $table WHERE $where";
		$query = mysqli_query($koneksi, $sql);
		while ($data = mysqli_fetch_array($query))
			$isi[] = $data;
		return @$isi;
	}

	function tampill($koneksi, $table, $where){
		$sql = "SELECT * FROM $table WHERE $where";
		$query = mysqli_query($koneksi, $sql);
		while ($data = mysqli_fetch_array($query))
			$isi[] = $data;
		return @$isi;
	}

	function hapus($koneksi, $table, $where, $form){
		$sql = "DELETE FROM $table WHERE $where";
		$query = mysqli_query($koneksi, $sql);
		if($query){
			echo "<script>alert('BERHASIL');document.location.href='$form'</script>";
		}else{
			"<script>alert('GAGAL');document.location.href='$form'</script>";
		}
	}

	function edit($koneksi, $table, $where){
		$sql = "SELECT * FROM $table WHERE $where";
		$query = mysqli_query($koneksi, $sql);
		$isi = mysqli_fetch_array($query);
		return $isi;
	}

	function ubah($koneksi, $table, $isi, $where, $form){
		$sql = "UPDATE $table SET $isi WHERE $where";
		$query = mysqli_query($koneksi, $sql);
		if($query){
			echo "<script>alert('BERHASIL');document.location.href='$form'</script>";
		}else{
			echo "<script>alert('GAGAL');document.location.href='$form'</script>";
		}
	}

	public function autokode($koneksi,$table,$field,$pre){
       $sqlc   = "SELECT COUNT($field) as jumlah FROM $table";
       $querys = mysqli_query($koneksi,$sqlc);
       $number = mysqli_fetch_assoc($querys);
       if($number['jumlah'] > 0){
            $sql    = "SELECT MAX($field) as kode FROM $table";
            $query  = mysqli_query($koneksi,$sql);
            $number = mysqli_fetch_assoc($query);
            $strnum = substr($number['kode'], 2,3);
            $strnum = $strnum + 1;
            if(strlen($strnum) == 3){ 
                $kode = $pre.$strnum;
            }else if(strlen($strnum) == 2){ 
                    $kode = $pre."0".$strnum;
            }else if(strlen($strnum) == 1){ 
                $kode = $pre."00".$strnum;
            }
        }else{
            $kode = $pre."001";
        }

        return $kode;
    }

    public function daylate($koneksi, $tanggala, $tanggalb,$form){
    	$sql = "SELECT DATEDIFF($tanggala,'$tangalb')";
		$query = mysqli_query($koneksi, $sql);
		if($query){
			echo "<script>alert('Day late berhasil');document.location.href='$form'</script>";
		}else{
			echo "<script>alert('Day late gagal');document.location.href='$form'</script>";
		}
    }
}

?>