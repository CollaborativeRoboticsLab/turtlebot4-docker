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
