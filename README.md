bag_convert
---


# Install
```shell
# setup
git clone --recurse-submodules https://github.com/0x126/bag_converter.git
cd bag_converter/docker
./build.sh
```


# Example
```shell
docker run -it --rm -v {YOUR_ROABAG_PATH}:/bag bag_converter:latest ros2 run bag_manipulate seyond_nebula_bag_decoder /bag/xxxx.mcap /bag/yyyy
```