#!/bin/bash
PUBIP=`dig +short myip.opendns.com @resolver1.opendns.com`
ANSWER=`dig +noall +answer -x $PUBIP resolver1.opendns.com | head -n 1 | awk -F. '{print $(NF-2)}'`
AUTHORITY=`dig +noall +authority -x $PUBIP resolver1.opendns.com | head -n 1 | awk -F. '{print $(NF-2)}'`
RESPONSE=$ANSWER$AUTHORITY
printf '%s\n' "${RESPONSE//[[:digit:]]/}"
