FROM ros:jazzy
FROM ros:jazzy

ENV DEBIAN_FRONTEND=noninteractive \
    RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    ROS_DOMAIN_ID=0 \
    ROS_DISCOVERY_SERVER=127.0.0.1:11811 \
    QT_X11_NO_MITSHM=1

# Install only required ROS packages; rely on their GUI deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ros-jazzy-turtlebot4-description \
      ros-jazzy-turtlebot4-msgs \
      ros-jazzy-turtlebot4-navigation \
      ros-jazzy-turtlebot4-node \
      ros-jazzy-turtlebot4-desktop \
      ros-jazzy-rmw-fastrtps-cpp \
      ros-jazzy-navigation2 \
      ros-jazzy-nav2-bringup \
      ros-jazzy-slam-toolbox && \
    rm -rf /var/lib/apt/lists/*

# Copy entrypoint script
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]