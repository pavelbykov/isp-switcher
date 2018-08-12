#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

from argparse import ArgumentParser
from librouteros import connect
import subprocess


#Get current provider

#Run "Get My ISP"(tm) script
bashCommand = "../get-my-isp/get-my-isp.sh"

process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
provider=output.decode('utf-8').rstrip()
print("Current provider is: ", provider, "\n")


argParser = ArgumentParser(description='ISP Setter')
argParser.add_argument(
        'host', type=str, help="ISP Name to make primary")
args = argParser.parse_args()


if args.host != provider :
   print("Will connect to ", args.host)
else:
   print("Provider is already", provider, ". Quitting")
   quit()


HighPriority = 150
LowPriority = 120

if args.host == "elreko" :
   starnetpriority = LowPriority
   elrekopriority = HighPriority
elif args.host == "starnet":
   starnetpriority = HighPriority
   elrekopriority = LowPriority
else:
  print("unrecognized ISP")
  quit()

print("High priority is", HighPriority)
print("Low priority is", LowPriority)
print("starnet priority will be set to", starnetpriority)
print("elreko priority will be set to", elrekopriority)
print("\n")



#Configure elreko
api = connect(username='<username>', password='<password>', host='172.22.30.3')
provider = "elreko"
#
vrrp=api(cmd='/interface/vrrp/print')
for item in vrrp:
  itemized = item

vrrpintid = itemized[".id"]

if itemized["priority"] == elrekopriority :
   print(provider, "priority already set to", itemized["priority"])
else:
   print(provider, "current priority is", itemized["priority"])
   print(provider, "configuring new priority", elrekopriority)
   params = {'priority': elrekopriority, '.id': vrrpintid}
   api(cmd='/interface/vrrp/set', **params)


#Verify if the change was performed correctly
vrrp=api(cmd='/interface/vrrp/print')
for item in vrrp:
  itemized = item
if itemized["priority"] == elrekopriority :
   print(provider, "priority set correctly")
else:
   print(provider, "priority incorrect. Expected ", elrekopriority, " received ", itemized["priority"])
   api.close()
   quit()


api.close()



#Configure starnet
api = connect(username='<username>', password='<password>', host='172.22.30.2')
provider = "starnet"
#
vrrp=api(cmd='/interface/vrrp/print')
for item in vrrp:
  itemized = item

vrrpintid = itemized[".id"]

if itemized["priority"] == starnetpriority :
   print(provider, "priority already set to ", itemized["priority"])
else:
   print(provider, "current priority is ", itemized["priority"])
   print(provider, "configuring new priority ", starnetpriority)
   params = {'priority': starnetpriority, '.id': vrrpintid}
   api(cmd='/interface/vrrp/set', **params)


#Verify if the change was performed correctly
vrrp=api(cmd='/interface/vrrp/print')
for item in vrrp:
  itemized = item
if itemized["priority"] == starnetpriority :
   print(provider, "priority set correctly")
else:
   print(provider, "priority incorrect. Expected ", starnetpriority, " received ", itemized["priority"])
   api.close()
   quit()


api.close()

