# Seyond Decoder Library

A C++ library for converting Seyond LiDAR `SeyondScan` messages to `sensor_msgs/PointCloud2` format.

## Overview

This library provides functionality to decode Seyond LiDAR data from the proprietary `SeyondScan` message format into standard ROS2 `PointCloud2` messages. It is designed to be used as a library in other ROS2 packages, particularly for bag file processing and manipulation.

## Features

- Converts `seyond_lidar_ros::msg::SeyondScan` to `sensor_msgs::msg::PointCloud2`
- Supports both spherical and XYZ point cloud data formats
- Configurable range filtering (min/max range)
- Configurable coordinate system transformation
- Support for intensity/reflectance selection
- Integration with Seyond SDK for hardware-specific optimizations

## Dependencies

- ROS2 (Humble or later)
- PCL (Point Cloud Library)
- Eigen3
- seyond_lidar_ros package
- Seyond SDK (included in seyond_lidar_ros)

## Building

```bash
# In your ROS2 workspace
cd ~/ros2_ws/src
# Clone or copy the seyond_decoder package
colcon build --packages-select seyond_decoder
```

## Usage

### As a Library

Include the library in your CMakeLists.txt:

```cmake
find_package(seyond_decoder REQUIRED)
target_link_libraries(your_target seyond_decoder)
```

In your C++ code:

```cpp
#include "seyond_decoder/seyond_decoder.hpp"

// Create decoder with configuration
seyond::DecoderConfig config;
config.max_range = 200.0;
config.min_range = 0.3;
config.frame_id = "lidar";

seyond::SeyondDecoder decoder(config);

// Convert SeyondScan to PointCloud2
auto pointcloud = decoder.convert(seyond_scan_msg);
```

### Example Node

Run the example node that subscribes to SeyondScan and publishes PointCloud2:

```bash
ros2 run seyond_decoder seyond_decoder_example \
  --ros-args \
  -p input_topic:=/seyond_scan \
  -p output_topic:=/pointcloud \
  -p max_range:=100.0 \
  -p min_range:=0.5
```

### Bag File Conversion

Use the bag_manipulate_integration example to convert bag files:

```bash
ros2 run seyond_decoder bag_manipulate_integration \
  input.mcap output.mcap /seyond_scan /pointcloud
```

## Configuration

The `DecoderConfig` structure supports the following parameters:

- `max_range`: Maximum range for points (meters)
- `min_range`: Minimum range for points (meters)
- `coordinate_mode`: Coordinate system mode (0=default, 1=flipped-Y, 2=swapped-XY)
- `use_reflectance`: Use reflectance values for intensity (true/false)
- `frame_id`: Frame ID for the output point cloud

## Integration with bag_manipulate

This library is designed to work seamlessly with the bag_manipulate package. You can extend the `BagManipulator` class to use this decoder:

```cpp
#include "seyond_decoder/seyond_decoder.hpp"

class SeyondBagManipulator : public BagManipulator {
  // Use SeyondDecoder to convert messages during bag processing
  seyond::SeyondDecoder decoder_;
  // ... implementation
};
```

## License

Apache License 2.0