mkdir -p ~/minio/data

docker run \
   -p 9110:9000 \
   -p 9111:9001 \
   --name minio \
   -v ~/minio/data:/data \
   quay.io/minio/minio server /data --console-address ":9111"
