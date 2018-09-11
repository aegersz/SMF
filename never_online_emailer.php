<?php

// SET THESE FIRST !
$servername = "localhost";
$username = "dbuser";
$password = "dbpass";
$dbname = "smf209";
$tbpref = "smf209_";
$domain = "forum.site-name.org";

$days_since_registered = 30;
$do_email = 1; 	// enable to send emails
$do_delete = 0; // enable to remove members forcefully (NOT ADVISABLE as "Forum > Maintenance > Routine" repairs are required afterwards)

$connect = new mysqli($servername, $username, $password, $dbname);
if ($connect->connect_error) {
        die("Connection failed: " . $connect->connect_error);
}

$sql = "SELECT * FROM" . " " . $tbpref . "members WHERE last_login = '0'";
//$sql = "SELECT * FROM" . " " . $tbpref . "members WHERE member_name = 'testr'";

$result = $connect->query($sql);

if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
                $datereg = $row["date_registered"];
                $current_date = date("U") /* to have it in microseconds */;
                $your_month = date("m", $datereg);
                $your_day = date("d", $datereg);
                $your_year =  date("Y", $datereg);
                $selected_date_stamp = mktime(0,0,0,$your_month,$your_day,$your_year);
                $selected_date = date("U",$selected_date_stamp);
                $difference = round (($current_date - $selected_date)/(3600*24));
                if ($difference >= $days_since_registered) {
                        echo $row["member_name"] . " " . $row["email_address"] . " " . "registered" . " " . $difference . " " . "days ago" . PHP_EOL;
                        $to_member =  $row["member_name"];
                        $from_name = "SMF Administrator";
                        $from_email = "smfadmin@" . $domain;
                        $headers = "From: $from_name <$from_email>";
                        $body = "Dear $to_member, \n
You have never logged in to https://$domain since you joined us so I will be removing you soon unless you do so. \n
I have already activated your account but both that email and your activation mail probably went to your spam folder. \n
If you have any questions or need any help on this matter then just reply to me. \n
Regards, \n
Server Admin";
                        $subject = "Regarding your inactive membership";
                        $to_email = $row["email_address"];

                        if ($do_email) {
                                if (mail($to_email, $subject, $body, $headers)) {
                                        echo "email sent" . " ";
                                } else {
                                        echo "email failed" . " ";
                                }
                        }

                        if ($do_delete) {
                                $sql2 = "DELETE FROM" . " " . $tbpref . "members WHERE member_name = '$to_member' ";
                                if ($connect->query($sql2) === TRUE) {
                                        echo "$to_member deleted successfully";
                                } else {
                                        echo "Error deleting record: " . $connect->error;
                                }
                        }
                }
        }
} else {
        echo "0 results";
}

$connect->close();
?>
