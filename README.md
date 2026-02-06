# Turtlebot4 Docker

This repo provides multiple containers to work with Turtlebot4 Robots in [DiscoveryServer Mode](https://turtlebot.github.io/turtlebot4-user-manual/setup/discovery_server.html). 

This pacakge provides and utilizes following containers

- **Turtlebot4-Discovery**          
    Provides the discovery service for the simulation

- **Turtlebot4-Simulation**         
    Provides the Gazebo based simulation environment

- **Turtlebot4-Rviz**   
    Provides rviz tools to interact with both simulation and physical robots

- **Turtlebot4-workspace**  
    Provides a workspace that can be used to test code on both simulation and physical robots

This packages contains two compose files that handles environmental variable configurations for Discovery Server on behalf of the user, so the user can focus on development without configuration worries

- `compose.yaml` for simulated robot
- `compose.physical` for physical robot (assumes Nav2 & Slamtoolbox is running natively on the robot)

### Information

Read more information on following documents

- [Container Information](./docs/containers.md)
- [Troubleshooting](./docs/troubleshooting.md)


## Install Docker

Follow the official instructions [here](https://docs.docker.com/engine/install/)

## Clone the repo

On the terminal run the following command to clone the repo

```sh
git clone https://github.com/CollaborativeRoboticsLab/turtlebot4-docker.git
```

## Start the workspace

Enter the folder

```bash
cd turtlebot4-docker
```

Pull the latest docker containers
```bash
docker compose pull
```

Required environmental variable need to be in a `.env` file. An `example.env` file is available. Rename that file to `.env` and update the values as required. 

### Workspace via code-server

When the stack is up, the workspace container serves a web VS Code at http://127.0.0.1:8080.

- Default password: `student` (set via `PASSWORD` in compose)
- Workspace folder: `/workspace` (mounted from `./turtlebot4-workspace/workspace`)
- Settings/extensions persist to:
    - `./turtlebot4-workspace/code-server/config` → `/root/.config/code-server`
    - `./turtlebot4-workspace/code-server/data` → `/root/.local/share/code-server`

To change the password, edit the `PASSWORD` env in [compose.yaml](compose.yaml) under the `turtlebot4-workspace` service.

<br>

## Use the Simulation robot

On the `compose.yaml` file, Change the following line to select mapping or localization.

```yaml
command: ["ros2", "launch", "turtlebot4_gz_bringup", "turtlebot4_gz.launch.py", "nav2:=true", "localization:=true", "slam:=false", "use_sim_time:=true"]
```

- `slam:=true` will allow the simulated robot to map the room. use gazebo joystick option to move the robot
- `nav2:=true` along with `localization:=true` to navigate the robot. Default is warehouse

Start the docker containers
```bash
docker compose up
```

For GUI containers (simulation, rviz), allow X11 access on the host if needed:
```bash
# Allow local-root X11 access for GUI apps in containers
xhost +local:root
```

## Using the Physical robot and remote pc

### Mapping

On the robot run following command to run the mapping process. Use a name like `office` to save the file

```bash
ros2 launch turtlebot4_navigation slam.launch.py
```

Move the robot using joystick to map the room.

### Navigation and Localization

On the robot run following command to run the localization process with a created map

```bash
ros2 launch turtlebot4_navigation localization.launch.py map:=office.yaml
```

And on another terminal run nav2

```bash
ros2 launch turtlebot4_navigation nav2.launch.py
```

Then use the `2D pose Estimate` tool to align the robot's laser scan with the map. Finally give a Navigation goal via `Nav2 Goal` tool

### Visualization on remote pc

Export following commands on the remote pc terminal. Make sure the `ROS_DOMAIN_ID` and `ROS_DISCOVERY_SERVER` matches the robot's configuration.

```bash
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
export ROS_SUPER_CLIENT=True
export ROS_DOMAIN_ID=10
export ROS_DISCOVERY_SERVER="10.42.0.1:11811;"
```

And then run the following command to open rviz

```bash
ros2 launch turtlebot4_viz view_navigation.launch.py
```

### Visualization on remote pc via docker container

Update the `compose-physical.yaml` file with correct configuration on following parameters

```yaml
- ROS_DOMAIN_ID=10
- RMW_IMPLEMENTATION=rmw_fastrtps_cpp
- ROS_DISCOVERY_SERVER=10.42.0.1:11811
- ROS_SUPER_CLIENT=1
```

Allow permission for UI interfaces from docker containers
```bash
# Allow local-root X11 access for GUI apps in containers
xhost +local:root
```

Start the docker containers
```bash
docker compose -f compose-physical.yaml up
```

## Doing custom work

Use code-server to edit files under `/workspace` (mounted from `./turtlebot4-workspace/workspace`). We recommend creating a ROS 2 colcon workspace inside `/workspace`:

```bash
# In the code-server terminal (already sourced via ros entrypoint)
mkdir -p /workspace/turtle_ws/src
cd /workspace
colcon build --merge-install

# Use the overlay
source /workspace/install/setup.bash
ros2 pkg list
```

Place your packages in `/workspace/turtle_ws/src`, build with `colcon`, and run as usual. The code-server terminal is ROS-ready (environment is sourced by the container entrypoint).
