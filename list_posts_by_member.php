<?php

// SET THESE !
$servername = "localhost";
$username = "dbuser";
$password = "dbpass";
$dbname = "smf209";
$poster = "smfadmin";
$timezone = "Australia";

date_default_timezone_set(' $timezone' );

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
                $datePost_month = date("m", $datePost);
                $datePost_day = date("d", $datePost);
                $datePost_year = date("Y", $datePost);
                $datePost_hour = date("h", $datePost);
                $datePost_minute = date("i", $datePost);
                $datePost_second = date("s", $datePost);
                echo $datePost_day . "/" . $datePost_month . "/" . $datePost_year . " at " . $datePost_hour . "/" . $datePost_minute . "/" . $datePost_second;
                echo "<br/>";
                echo " ". PHP_EOL ."<br/>";
                echo $row['body']. PHP_EOL. "<br/>";
                echo " ". PHP_EOL ."<br/>";
        }
} else {
        echo "0 results";
}

$conn->close();
?>

