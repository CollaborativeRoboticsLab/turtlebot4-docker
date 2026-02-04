FROM ros:jazzy

# Install dependencies

RUN apt update && \
    apt install -y --no-install-recommends ros-jazzy-turtlebot4-description \
    ros-jazzy-turtlebot4-msgs \
    ros-jazzy-turtlebot4-navigation \
    ros-jazzy-turtlebot4-node \
    ros-jazzy-rmw-fastrtps-cpp \
    ros-jazzy-navigation2 \
    ros-jazzy-nav2-bringup \
    ros-jazzy-slam-toolbox

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811
ENV TERM=xterm-256color

# Copy entrypoint script
COPY ros_entrypoint.sh /ros_entrypoint.sh

# Ensure entrypoint is executable and used
RUN chmod +x /ros_entrypoint.sh

# Ensure the entrypoint script is used
ENTRYPOINT ["/ros_entrypoint.sh"]
