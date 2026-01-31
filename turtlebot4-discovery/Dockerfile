FROM ros:jazzy

# Install dependencies

RUN apt update && \
    apt install -y --no-install-recommends ros-jazzy-rmw-fastrtps-cpp

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV ROS_DOMAIN_ID=0
ENV SERVER_ID=0
ENV SERVER_IP=127.0.0.1
ENV SERVER_PORT=11811

# Expose Fast DDS Discovery Server UDP port (optional if server runs here)
EXPOSE ${SERVER_PORT}/udp

# Copy entrypoint script
COPY ros_entrypoint.sh ros_entrypoint.sh

# Ensure entrypoint is executable and used
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

# Start Fast DDS discovery server (env-expanded shell form)
CMD fastdds discovery --server-id ${SERVER_ID} --udp-address ${SERVER_IP} --port ${SERVER_PORT}