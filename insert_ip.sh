#! /bin/sh
sed "s/{{WPIP}}/$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' wp_wordpress_1)/g"  nginx.conf.tmp > nginx.conf 
