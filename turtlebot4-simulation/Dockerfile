FROM ros:jazzy

# Install dependencies

RUN apt update && \
    apt install -y --no-install-recommends ros-jazzy-turtlebot4-description \
    ros-jazzy-turtlebot4-msgs \
    ros-jazzy-turtlebot4-navigation \
    ros-jazzy-turtlebot4-node \
    ros-jazzy-turtlebot4-simulator \
    ros-jazzy-irobot-create-nodes \
    ros-dev-tools

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

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV ROS_DOMAIN_ID=0

# Copy entrypoint script
COPY ros_entrypoint.sh ros_entrypoint.sh

RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT [ "/ros_entrypoint.sh" ]