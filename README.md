# Turtlebot4 Docker

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

Allow permission for UI interfaces from docker containers
```bash
# Allow local-root X11 access for GUI apps in containers
xhost +local:root
```

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

Copy your packages or create your pacakges within `/turtlebot4-workspace/turtle_ws/src` this folder is mounted into the workspace container and packages can be compiled and executed within the container.

## Information

Read more information on following documents

- [Container Information](./docs/containers.md)
- [Troubleshooting](./docs/troubleshooting.md)

