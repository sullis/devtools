mkdir -p ~/minio/data

docker run \
   -p 9000:9000 \
   -p 9001:9001 \
   --name minio \
   -v ~/minio/data:/data \
   -e "MINIO_ROOT_USER=miniofun" \
   -e "MINIO_ROOT_PASSWORD=miniofun" \
   quay.io/minio/minio server /data --console-address ":9001"
