tag=$1
name="hdmapnet:$tag"
image_name="ghcr.io/honda-research-institute/$name"

docker build -f docker/Dockerfile -t=$image_name .
