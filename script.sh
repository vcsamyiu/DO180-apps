#!/bin/bash
echo "remove all running images"
sudo podman rm -a -f
sudo podman rmi samdock -f
sudo rm -rf samdock.tar
echo "create samsql"
sudo podman run -d -v /sam/mysql/data:/var/lib/mysql/data -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 --name samsql --ip 10.88.100.109 rhscl/mysql-56-rhel7
echo "stop samsql"
sudo podman stop samsql
sleep 10
echo "snapshot modified image"
sudo podman commit samsql samdock
sleep 10
echo "backup samdock"
sudo podman save -o samdock.tar samdock
sleep 20
echo "remove and restore samdock"
sudo podman rmi samdock
sudo podman load -i samdock.tar
sleep 20
sudo podman rm -f -a
echo "run samdock"
sudo podman run -d -v /sam/mysql/data:/var/lib/mysql/data -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=db -p 3306:3306 --name samsql --ip 10.88.100.109 samdock
sudo podman ps 
sudo podman logs --tail=10 samsql
sudo podman inspect samsql | grep -i usage
sudo rm -rf samdock.tar
