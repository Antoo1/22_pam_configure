#!/bin/bash
echo "user is --------------- $PAM_USER" > /tmp/a
#Первое условие: если день недели суббота или воскресенье
if [ $(date +%a) = "Sat" ] || [ $(date +%a) = "Sun" ] || [ $(date +%a) = "Thu" ] ; then
 #Второе условие: входит ли пользователь в группу admin
 if getent group admin | grep -qw "$PAM_USER"; then
        echo "Если пользователь входит в группу admin, то он может подключиться" >> /tmp/a
        exit 0
      else
        echo "Иначе ошибка (не сможет подключиться)" >> /tmp/a
        exit 1
    fi
  echo "Если день не выходной, то подключиться может любой пользователь" >> /tmp/a
  else
    exit 0
fi

