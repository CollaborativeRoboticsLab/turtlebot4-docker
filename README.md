# Algorithmic Robots Simulation World

## Install Docker

Follow the official instructions [here](https://docs.docker.com/engine/install/)

## Clone the repo

On the terminal run the following command to clone the repo

```sh
git clone https://github.com/CollaborativeRoboticsLab/algorithmic-robots-world.git
```

## Start the workspace

Enter the folder

```bash
cd algorithmic-robots-world
```

Pull the latest docker containers
```bash
docker compose pull
```

Allow permission for UI interfaces from docker containers
```bash
# Allow local-root X11 access for GUI apps in containers
xhost +local:root
```

Start the docker containers
```bash
docker compose up
```

## Information

### `Turtlebot4-discovery` container

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

### `Turtlebot4-simulation` container

This container (along with Turtlebot4-discovery container) provides a drop-in replacement for a Turtlebot4 robot that utilize discovery server.

Works as a client of turtlebot4-discovery, and thus update the following variables if turtlebot4-discovery settings change.

```yaml
- ROS_DOMAIN_ID=0
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=127.0.0.1:11811
```

Parameter descriptions:
- `ROS_DOMAIN_ID`: Must match the discovery server and all other clients.
- `RMW_IMPLEMENTATION`: Keep `rmw_fastrtps_cpp` to use Fast DDS with discovery server.
- `ROS_DISCOVERY_SERVER`: Address of the discovery server the client connects to. Use `127.0.0.1:11811` when all services use `network_mode: host` on the same machine. If the server runs on another host, set `<server-host-ip>:11811`.

Notes:
- With `network_mode: host`, containers share the host network namespace, so `127.0.0.1` refers to the host where the server binds. Additionally `ipc: host` is required for the host to differentiate containers.
- If you change the server port, update this value accordingly (e.g., `127.0.0.1:<new_port>`).

### `Turtlebot4-control (RViz)` container

This container shows a typical client (RViz + Nav2) connecting to Turtlebot4 simulation (or a physical robot).

Works as a client of turtlebot4-discovery, and thus update the following variables if turtlebot4-discovery settings change.

```yaml
- ROS_DOMAIN_ID=0
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=127.0.0.1:11811
```

Parameter descriptions:
- `ROS_DOMAIN_ID`: Same domain as simulation and discovery.
- `RMW_IMPLEMENTATION`: Keep Fast DDS for discovery server support.
- `ROS_DISCOVERY_SERVER`: Discovery server endpoint as above.

## Troubleshooting

- **Clients fail to connect:** Ensure `ROS_DISCOVERY_SERVER` uses a concrete address (not `0.0.0.0`). With host networking, use `127.0.0.1:11811`. Across machines, use the server host IP.
- **Firewall/port issues:** Confirm the server listens on `11811` and the port is open.
- **GUI not showing:** Run `xhost +local:root` before `docker compose up`; verify `/tmp/.X11-unix` is mounted and `DISPLAY` is set.
- **Verify ROS graph:** Inside `turtlebot4-simulation`, run `ros2 topic list`, check `/map`, `/tf`, and Nav2 nodes (`planner_server`, `controller_server`). Ensure transforms between `map`, `odom`, and `base_link` are present.

## Tips
- Keep `ROS_DOMAIN_ID` and `RMW_IMPLEMENTATION` consistent across all services.
- If you prefer flexible configuration, create a `.env` file with `HOST_IP=127.0.0.1` and set `ROS_DISCOVERY_SERVER=${HOST_IP}:11811` in compose.