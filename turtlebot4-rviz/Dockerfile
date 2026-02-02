FROM ros:jazzy

# Install dependencies

RUN apt update && \
    apt install -y --no-install-recommends ros-jazzy-turtlebot4-description \
    ros-jazzy-turtlebot4-desktop \
    ros-jazzy-rmw-fastrtps-cpp 

# Install x11 apps dependencies

RUN apt-get update && \
    apt-get install -y --no-install-recommends libx11-6 \
                                               libxext6 \
                                               libxrender1 \
                                               libxtst6 \
                                               libxi6 \
                                               libgtk-3-0 \
                                               x11-xserver-utils \
                                               ffmpeg \
                                               libsm6 \
                                               unzip \
                                               findutils

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811

# Copy entrypoint script
COPY ros_entrypoint.sh ros_entrypoint.sh

RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]