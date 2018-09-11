<?php

// SET THESE FIRST !
$servername = "localhost";
$username = "dbuser";
$password = "dbpass";
$dbname = "smf209";
$tbpref = "smf209_";
$domain = "forum.site-name.org";

$days_not_logged_in = 365; 	// only those who have not not logged for 365 days or more
$do_email = 0; 			// enable to send emails

$connect = new mysqli($servername, $username, $password, $dbname);
if ($connect->connect_error) {
        die("Connection failed: " . $connect->connect_error);
}

$sql = "SELECT * FROM" . " " . $tbpref . "members ORDER BY last_login";
//$sql = "SELECT * FROM" . " " . $tbpref . "members WHERE member_name = 'test' ORDER BY last_login";

$result = $connect->query($sql);

if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
                if (!empty($row["last_login"])) {
                        $dateSin =  $row["last_login"];
                        $current_date = date("U") /* to have it in microseconds */;
                        $your_month = date("m", $dateSin);
                        $your_day =  date("d", $dateSin);
                        $your_year =  date("Y", $dateSin);
                        $selected_date_stamp = mktime(0,0,0,$your_month,$your_day,$your_year);
                        $selected_date = date("U",$selected_date_stamp);
                        $difference = round (($current_date - $selected_date)/(3600*24));
			if ($difference >= $days_not_logged_in) {
				echo $row["member_name"] . " " . $row["email_address"] . " " . "posts=" . $row["posts"] . " ";
				echo "Last logged in" . " " . $difference . " " . "days ago" . PHP_EOL;
			        $to_member =  $row["member_name"];
			        $from_name = "SMF Administrator";
                        	$from_email = "smfadmin@" . $domain;
                        	$headers = "From: $from_name <$from_email>";
                        	$body = "Dear $to_member, \n
We miss you as you have not logged in to https://$domain for over $difference days. \n
Please come and visit us soon! \n
Regards, \n
Server Admin";
	        		$subject = "Regarding your last login";
	        		$to_email = $row["email_address"];
	        		if ($do_email) {
	        			if (mail($to_email, $subject, $body, $headers)) {
	                			echo "email sent" . " ";
	      				} else {
	        				echo "email failed" . " ";
	      				}
				} 
                        }
                }
	}
} else {
        echo "0 results";
}

$connect->close();
?>
