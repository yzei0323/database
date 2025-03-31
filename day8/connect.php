<?php
$server = "localhost:1521";
$user = "scott";
$password = "tiger";
$dbname ="testdb";

$conn = new mysql($server, $user, $password, $dbname);

if($conn->connect_error) echo "<h2>접속에 실패하였습니다</h2>";
else echo "<h2>접속 성공</h2>";

?>