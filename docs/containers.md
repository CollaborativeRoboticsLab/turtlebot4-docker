# Container Details

## `Turtlebot4-discovery` container

This container provides the discovery server utilized by the FastRTPS.

To customize, change the following environment variables:

```yaml      
- ROS_DOMAIN_ID=0
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- SERVER_ID=0
- SERVER_IP=0.0.0.0
- SERVER_PORT=11811
```

Parameter descriptions:
- `ROS_DOMAIN_ID`: DDS domain identifier. All communicating nodes must share the same domain ID (default `0`). Use different IDs to isolate systems.
- `RMW_IMPLEMENTATION`: ROS 2 middleware layer. `rmw_fastrtps_cpp` selects Fast DDS (required for discovery server).
- `SERVER_ID`: Unique identifier for the discovery server instance. Use `0` for a single server; increment for multiple servers.
- `SERVER_IP`: Bind address for the discovery server. `0.0.0.0` listens on all interfaces; set a specific host IP to restrict binding.
- `SERVER_PORT`: Listening port for the discovery server (default `11811`). Ensure this port is open in your firewall.

## `Turtlebot4-simulation` container

This container (along with Turtlebot4-discovery container) provides a drop-in replacement for a Turtlebot4 robot that utilize discovery server.

Works as a client of turtlebot4-discovery, and thus update the following variables if turtlebot4-discovery settings change.

```yaml
- ROS_DOMAIN_ID=0
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=127.0.0.1:11811
```

**Parameter descriptions**

- `ROS_DOMAIN_ID`: Must match the discovery server and all other clients.
- `RMW_IMPLEMENTATION`: Keep `rmw_fastrtps_cpp` to use Fast DDS with discovery server.
- `ROS_DISCOVERY_SERVER`: Address of the discovery server the client connects to. Use `127.0.0.1:11811` when all services use `network_mode: host` on the same machine. If the server runs on another host, set `<server-host-ip>:11811`.

**Data Persistance**

- `turtlebot4-simulation/gazebo_data` will hold the downloaded gazebo assets
- `turtlebot4-simulation/rviz` will hold the maps and other files created by rviz. use `/rviz` as a prefix for file name or save to `/rviz` folder via wizard.

Notes:
- With `network_mode: host`, containers share the host network namespace, so `127.0.0.1` refers to the host where the server binds. Additionally `ipc: host` is required for the host to differentiate containers.
- If you change the server port, update this value accordingly (e.g., `127.0.0.1:<new_port>`).

## `Turtlebot4-rviz` container

This container shows a typical client (RViz + Nav2) connecting to Turtlebot4 simulation (or a physical robot).

Works as a client of turtlebot4-discovery, and thus update the following variables if turtlebot4-discovery settings change.

```yaml
- ROS_DOMAIN_ID=0
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=127.0.0.1:11811
```

**Parameter descriptions**
- `ROS_DOMAIN_ID`: Same domain as simulation and discovery.
- `RMW_IMPLEMENTATION`: Keep Fast DDS for discovery server support.
- `ROS_DISCOVERY_SERVER`: Discovery server endpoint as above.