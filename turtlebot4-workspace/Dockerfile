FROM ros:jazzy

## Install ROS dependencies and code-server
ARG CODE_SERVER_VERSION=4.91.0
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
            ros-jazzy-turtlebot4-description \
            ros-jazzy-turtlebot4-msgs \
            ros-jazzy-turtlebot4-navigation \
            ros-jazzy-turtlebot4-node \
            ros-jazzy-rmw-fastrtps-cpp \
            ros-jazzy-rmw-cyclonedds-cpp \
            ros-jazzy-navigation2 \
            ros-jazzy-nav2-bringup \
            ros-jazzy-slam-toolbox \
            curl \
            ca-certificates && \
        curl -fOL https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        apt-get install -y --no-install-recommends ./code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        rm -f code-server_${CODE_SERVER_VERSION}_amd64.deb && \
        rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV ROS_DISCOVERY_SERVER=127.0.0.1:11811
ENV TERM=xterm-256color
ENV NO_AT_BRIDGE=1
ENV QT_X11_NO_MITSHM=1
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Default workspace served by code-server
WORKDIR /workspace

# Expose code-server port
EXPOSE 8080

# Copy entrypoint script
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

# Ensure the entrypoint script is used
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/usr/bin/code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "--disable-telemetry", "/workspace"]
