## Start the workspace based on Simulation

Enter the folder

```bash
cd turtlebot4-docker
```

Pull the latest docker containers
```bash
docker compose -f compose-physical.yaml pull
```

### Configuration

Required environmental variable need to be in a `.env` file. An `example.env` file is available. Rename that file to `.env` and update the values as required. 

For the real robot operation, following parameters are relevant. In this scenario, the turtlebot4 robot (The raspberry pi 4 on the robot), contains the discovery server.

We connect our system (whatever we develop) with that, using following parameters.

```env
ROBOT_ROS_DOMAIN_ID=10
ROBOT_ROS_DISCOVERY_SERVER=10.0.0.192:11811
```

**ROS_DISCOVERY_SERVER** 
Each robot has a small display near its Power button. That shows the IP address. Other option is to connect to the Rpi's Ethernet via Ethernet cable and connect to the robot. Set remote machine's IP address 192.168.185.10, NetMask 255.255.255.0 and use SSH to connect. Use following command. Password is `turtlebot4`

```bash
ssh ubuntu@192.168.185.3
```

Once in the robot, use one of the following commands to check the ip address 

```bash
ros2 topic echo /ip
```

```bash
ip a #look for wlan
```

On your host macchine use this as the IP address for ROS_DISCOVERY_SERVER. Port is 11811


**ROS_DOMAIN_ID**

Use the domain id of the robot, generally this is matched to the robot's name. If the robot is `TBOT4-001`, the ROS_DOMAIN_ID is `1`.

Otherway to find out is SSH into the robot and run the following command

```bash
echo $ROS_DOMAIN_ID
```

Once these parameters has been identified update the `.env` file to match.

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

### Connecting the host machine with the robot

Update the `.env` as mentioned above. Then,

Allow permission for UI interfaces from docker containers and start the containers.

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

