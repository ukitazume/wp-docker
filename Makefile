WPIP = $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' wp_wordpress_1)
WPIP = "test"
create:
	docker create -v /var/lib/mysql --name mysqldata alpine:latest /bin/true
	docker create -v /var/www/html/wp-content --name wpdata alpine:latest /bin/true
backup:
	docker run --rm --volumes-from mysqldata -v ${PWD}:/backup alpine:latest tar cvf /backup/mysql.tar /var/lib/mysql
	docker run --rm --volumes-from wpdata -v ${PWD}:/backup alpine:latest tar cvf /backup/wp-content.tar /var/www/html/wp-content
restore:
	docker run --rm --volumes-from mysqldata -v ${PWD}:/backup alpine:latest /bin/sh -c "cd / && tar xvf /backup/mysql.tar"
	docker run --rm --volumes-from wpdata -v ${PWD}:/backup alpine:latest /bin/sh -c "cd / && tar xvf /backup/wp-content.tar"
template:
	chmod +x ./insert_ip.sh && ./insert_ip.sh
