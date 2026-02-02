FROM ros:jazzy AS base

# Install dependencies

RUN apt update && \
    apt install -y --no-install-recommends \
    git \
    ros-jazzy-irobot-create-nodes \
    ros-jazzy-rmw-fastrtps-cpp \
    ros-dev-tools \
    ros-jazzy-navigation2 \
    ros-jazzy-nav2-bringup \
    ros-jazzy-slam-toolbox

# Install Gazebo packages

RUN apt install -y curl && \
    curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null && \
    apt update && \
    apt install --no-install-recommends -y gz-harmonic

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

## Set up workspace
ENV WORKSPACE_ROOT=/turtle_ws

# Create and clone workspace
WORKDIR ${WORKSPACE_ROOT}/src

# Clone turtlebot4 simulation packages (with modified render engine)
RUN git clone -b jazzy https://github.com/CollaborativeRoboticsLab/turtlebot4.git

WORKDIR ${WORKSPACE_ROOT}

## Install dependencies using rosdep
RUN rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y

## Build the workspace
RUN . /opt/ros/jazzy/setup.sh && \
    colcon build --symlink-install

WORKDIR /

# Clean up workspace to reduce image size
RUN rm -rf ${WORKSPACE_ROOT}/src
RUN rm -rf ${WORKSPACE_ROOT}/log
RUN rm -rf ${WORKSPACE_ROOT}/build

# Clean up apt cache to reduce image size
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*
RUN apt-get clean

FROM ros:jazzy AS Final

# Set environment variables
ENV WORKSPACE_ROOT=/turtle_ws
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811

WORKDIR /

# Copy files from build stage
COPY --from=base / /

# Copy entrypoint script
COPY turtlebot4-simulation/ros_entrypoint.sh ros_entrypoint.sh

RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]