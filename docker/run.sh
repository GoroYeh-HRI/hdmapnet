tag=$1
name="hdmapnet:$tag"
image_name="ghcr.io/honda-research-institute/$name"

# --privileged gives the sudo permission
# docker run  your_image_name set shared memory to max
docker run \
    --gpus all \
    -v /home/$USER/planning:/home/$USER/planning \
    -w /home/$USER  \
    --user $(id -u):$(id -g) --privileged \
    -it $image_name bash
    # -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \