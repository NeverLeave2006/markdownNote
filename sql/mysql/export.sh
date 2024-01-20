docker run --name mysql-build-container mysql-build
docker cp mysql-build-container:/path/to/your/deb/file /host/path/to/copy/deb/file