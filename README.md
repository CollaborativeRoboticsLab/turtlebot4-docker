# Turtlebot4 Docker

This repo provides multiple containers to work with Turtlebot4 Robots in [DiscoveryServer Mode](https://turtlebot.github.io/turtlebot4-user-manual/setup/discovery_server.html). 

This pacakge provides and utilizes following containers

- **Turtlebot4-Discovery**          
    Provides the discovery service for the simulation
  
- **Turtlebot4**   
    Provides rviz, nav2 and slamtoolbox tools to interact with both simulation and physical robots

- **Turtlebot4-Simulation**         
    Provides the Gazebo based simulation environment

- **Turtlebot4-workspace**  
    Provides a workspace that can be used to test code on both simulation and physical robots

This packages contains two compose files that handles environmental variable configurations for Discovery Server on behalf of the user, so the user can focus on development without configuration worries

- `compose.yaml` for simulated robot
- `compose-physical.yaml` for physical robot

## Install Docker

Follow the official instructions [here](https://docs.docker.com/engine/install/)

## Clone the repo

On the terminal run the following command to clone the repo

```sh
git clone https://github.com/CollaborativeRoboticsLab/turtlebot4-docker.git
```

## Information

Read more information on following documents

- [Container and Parameter Information](./docs/parameters.md)
- [Troubleshooting](./docs/troubleshooting.md)
- [Starting the simulation](./docs/simulation.md)
- [Starting the physical robot](./docs/physical.md)




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
