FROM ros:jazzy

ENV DEBIAN_FRONTEND=noninteractive \
    WORKSPACE_ROOT=/turtle_ws \
    RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    ROS_DOMAIN_ID=0 \
    ROS_DISCOVERY_SERVER=127.0.0.1:11811 \
    QT_X11_NO_MITSHM=1

# Core ROS dependencies and build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      ros-dev-tools \
      ros-jazzy-irobot-create-* \
      ros-jazzy-rmw-fastrtps-cpp \
      ros-jazzy-navigation2 \
      ros-jazzy-nav2-bringup \
      ros-jazzy-slam-toolbox \
      curl && \
    curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends gz-harmonic && \
    rm -rf /var/lib/apt/lists/*

## Set up workspace
WORKDIR ${WORKSPACE_ROOT}/src

# Clone turtlebot4 simulation packages
RUN git clone -b jazzy https://github.com/CollaborativeRoboticsLab/turtlebot4.git && \
    git clone -b jazzy https://github.com/turtlebot/turtlebot4_simulator.git && \
    git clone -b jazzy https://github.com/turtlebot/turtlebot4_desktop.git

WORKDIR ${WORKSPACE_ROOT}

## Build the workspace (merged install to reduce size)
RUN . /opt/ros/jazzy/setup.sh && colcon build

RUN rm -rf build/ src/ log/

# Remove build-time tools to slim the image (keep runtime deps intact)
RUN apt-get purge -y --auto-remove git ros-dev-tools curl && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/* /var/tmp/*

WORKDIR /

# Copy entrypoint script
COPY turtlebot4-simulation/ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]