ISP Switcher
=============

Tool to switch ISPs in dual-homed setup with Mikrotik routers.
Each ISP is connected to a separate router.
Routers run virtual gateway for the hosts on the lan.

 +------+    +------+
 | ISP1 |    | ISP2 |
 +------+    +------+
    |            |
 +----+        +----+
 | R1 |        | R2 |
 +----+        +----+
    |            |
    |  +------+  |
    |  | VRRP |  |
    |  |  GW  |  |
    |  +--+---+  |
    |     |      |
    |     |      |
  --+----LAN-----+--

The script switches VRRP priority and verifies that the new ISP has been selected.

This script depends on librouteros to connect to Mikrotik routers.
This script depends on "get-my-isp.sh" to find out name of the ISP.



Installation
------------

Replace <username> and <password> with the credentials to the R1 and R2.
Credentials must allow interface level write.

Rename ISPs as needed.
To find out your current ISP "get-my-isp.sh" script is used.


Usage
-----


isp-switcher.sh <isp_name>

