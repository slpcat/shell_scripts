#!/bin/sh
NginxServer='web.site'
Check_Nginx_Server()
{

 http_status_code=$(curl -m 5 -s -i -w %{http_code} -o /tmp/index.html $NginxServer)
 if [ $http_status_code -eq 000 -o $http_status_code -ge 500 ];then
 echo "check http server error \nhttp_status_code is" $http_status_code
 date >> /tmp/srv.log
 service nginx restart
else
 http_content=$(curl -s ${NginxServer}) 
 echo "service status ok\n" $http_content

fi

}

Check_Nginx_Server

