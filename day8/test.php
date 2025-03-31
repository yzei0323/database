<?php

// Oracle DB 연결 정보 설정
$conn = oci_connect('scott', 'password', '//localhost/XEPDB1');

if (!$conn) {
    $e = oci_error();
    echo "Error connecting to the database: " . $e['message'];
} else {
    $query = "SELECT * FROM employees WHERE ROWNUM <= 10";
    
    $stid = oci_parse($conn, $query);
    oci_execute($stid);

    echo "<table border='1'>";
    
    // 테이블 헤더 생성
    $ncols = oci_num_fields($stid);
    echo "<tr>";
    for ($i = 1; $i <= $ncols; $i++) {
        $colname = oci_field_name($stid, $i);
        echo "<th>$colname</th>";
    }
    echo "</tr>";

    // 테이블 데이터 추가
    while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
        echo "<tr>";
        foreach ($row as $item) {
            echo "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>";
        }
        echo "</tr>";
    }
    
    echo "</table>";

    oci_free_statement($stid);
    oci_close($conn);
}
?>
