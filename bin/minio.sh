mkdir -p ~/minio/data

minio server --address ":9990" --console-address ":9991" ~/minio/data
