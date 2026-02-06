FROM ros:jazzy

ENV DEBIAN_FRONTEND=noninteractive \
    RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    ROS_DOMAIN_ID=0 \
    SERVER_ID=0 \
    SERVER_IP=127.0.0.1 \
    SERVER_PORT=11811

# Install only the needed RMW implementation and clean up in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends ros-jazzy-rmw-fastrtps-cpp && \
    rm -rf /var/lib/apt/lists/*

# Expose Fast DDS Discovery Server UDP port (optional if server runs here)
EXPOSE ${SERVER_PORT}/udp

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]

# Start Fast DDS discovery server (env-expanded shell form)
CMD fastdds discovery --server-id ${SERVER_ID} --udp-address ${SERVER_IP} --udp-port ${SERVER_PORT}