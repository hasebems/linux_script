#!/bin/sh
GPIO=11     #使用するGPIOポート
PUSHTIME=3  #押す秒数

#初期設定
echo "$GPIO" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio$GPIO/direction
echo "low" > /sys/class/gpio/gpio$GPIO/direction

#PUSHTIME秒間押されるまで待つ
cnt=0
while [ $cnt -lt $PUSHTIME ] ; do
  data=`cat /sys/class/gpio/gpio$GPIO/value`
  if [ "$data" -eq "1" ] ; then
    cnt=`expr $cnt + 1`
  else
    cnt=0
  fi
  sleep 1
done

#シャットダウンの実行
shutdown -h now
