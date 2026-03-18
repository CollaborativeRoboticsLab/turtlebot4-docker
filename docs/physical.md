## Start the workspace based on Simulation

Enter the folder

```bash
cd turtlebot4-docker
```

Pull the latest docker containers
```bash
docker compose pull
```

### Configuration

Required environmental variable need to be in a `.env` file. An `example.env` file is available. Rename that file to `.env` and update the values as required. 

For the simulation, following parameters are relevant.

```env
SERVER_ID=0
SERVER_IP=0.0.0.0
SERVER_PORT=11811
ROS_DOMAIN_ID=0
ROS_DISCOVERY_SERVER=127.0.0.1:11811
```

**SERVER_ID, SERVER_IP, SERVER_PORT**
Since the nodes related to the simulation runs on a single computer, these three parameters don't need to change.

**ROS_DOMAIN_ID**
Since there are students sharing a single wifi network, this needs to be set. Update this to be unique from other groups. Use a value between 0-255.

**ROS_DISCOVERY_SERVER** 
Leave this as it is if the SERVER_IP=0.0.0.0 and SERVER_PORT=11811, If these default values change, update the ROS_DISCOVERY_SERVER parameters such that,
`ROS_DISCOVERY_SERVER=SERVER_IP:SERVER_PORT`



## Using the Physical robot and remote pc

### Mapping

SSH into the robot and run the following command to start the SLAM process

```bash
ros2 launch turtlebot4_navigation slam.launch.py
```

Move the robot using joystick/teleop to map the room.

Give a name to the map file so the map can be saved.

### Localization

SSH into the robot and run the following command to start the localization process. Update the "map:=crlab.yaml" parameter with the correct file name.

```bash
ros2 launch turtlebot4_navigation localization.launch.py map:=crlab.yaml
```

Use the `2D pose Estimate` tool to align the robot's laser scan with the map.

> Note: Comparatively, SLAM is more resource intensive compared to localization. So its often recommended to use the localization where ever possible for long term exections 

### Starting the system

Update the `compose-physical.yaml` file or `.env` with correct configuration on following parameters

```yaml
- ROS_DOMAIN_ID=10
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=10.42.0.1:11811
- ROS_SUPER_CLIENT=1
```

Allow permission for UI interfaces from docker containers
```bash
xhost +local:root
docker compose -f compose-physical.yaml up
```























### Use the Simulation robot

On the `compose.yaml` file, Change the following line to select mapping or localization.

```yaml
command: ["ros2", "launch", "turtlebot4_gz_bringup", "turtlebot4_gz.launch.py", "nav2:=true", "localization:=true", "slam:=false", "use_sim_time:=true"]
```

- `slam:=true` will allow the simulated robot to map the room. use gazebo joystick option to move the robot. remember to save the mapping.
- `localization:=true` will allow the simulated robot to localize on a mapped room.
- `nav2:=true` along with `localization:=true` to navigate the robot. Default is warehouse.

Start the docker containers
```bash
xhost +local:root
docker compose up
```

### Workspace via code-server

When the stack is up, the workspace container serves a web VS Code at http://127.0.0.1:8080. Use this for your development work as the enviorment has been configured to work with turtlebot robots.

- Workspace folder: `/workspace` (mounted from `./turtlebot4-workspace/workspace`)
- Settings/extensions persist to:
    - `./turtlebot4-workspace/code-server/config` → `/root/.config/code-server`
    - `./turtlebot4-workspace/code-server/data` → `/root/.local/share/code-server`

