FROM ros:jazzy

# Install dependencies

RUN apt-get update && \
    apt-get install -y --no-install-recommends ros-jazzy-turtlebot4-description \
    ros-jazzy-turtlebot4-msgs \
    ros-jazzy-turtlebot4-navigation \
    ros-jazzy-turtlebot4-node \
    ros-jazzy-rmw-fastrtps-cpp \
    ros-jazzy-navigation2 \
    ros-jazzy-nav2-bringup \
    ros-jazzy-slam-toolbox

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
    findutils \
    gnome-terminal \
    dbus-x11 \
    gsettings-desktop-schemas \
    dconf-service \
    libglib2.0-bin \
    xterm

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Copy entrypoint script
COPY ros_entrypoint.sh /ros_entrypoint.sh

# Ensure entrypoint is executable and used
RUN chmod +x /ros_entrypoint.sh

# Ensure the entrypoint script is used
ENTRYPOINT ["/ros_entrypoint.sh"]
