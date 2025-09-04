#!/usr/bin/bash

source "/opt/ros/$ROS_DISTRO/setup.bash"
source /opt/drs/install/setup.bash
exec "$@"
