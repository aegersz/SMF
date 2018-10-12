<?php

// SET THESE !
$servername = "localhost";
$username = "dbuser";
$password = "dbpass";
$dbname = "smf209";
$poster = "smfadmin";
$timezone = "Australia";

date_default_timezone_set("Australia/Sydney");

echo <<< EOF
<head>
<meta charset="UTF-8">
</head>
EOF;

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM `smf209_messages` WHERE poster_name = '$poster' ORDER BY id_topic, poster_time";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
                echo PHP_EOL;
                echo "<hr> <strong>" . $row['subject'] . "</strong> by <strong>" . $row['poster_name'] . "</strong> on ";
                $datePost = $row["poster_time"];

