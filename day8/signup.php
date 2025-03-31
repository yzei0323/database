<?php
include_once("connect.php");

$m_id = $_POST["m_id"];
$m_name = $_POST["m_name"];
$m_birthday = $_POST["m_birthday"];
$m_tel = $_POST["m_tel"];
$m_rental_left = $_POST["m_rental_left"];

$sql ="INSERT INTO LIB_MEMBER (M_ID, M_NAME, M_TEL, M_BIRTHDAY,M_RENTAL_LEFT) 
VALUES ('$M_ID', '$M_NAME', '$M_TEL', '$M_BIRTHDAY','$M_RENTAL_LEFT')";

IF($conn->query($sql))echo "<h3>회원등록 성공</h3>";
else echo "<h3>회원등록 실패</h3>";

?>