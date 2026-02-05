# Troubleshooting

## Clients fail to connect:
  
Ensure `ROS_DISCOVERY_SERVER` uses a concrete address (not `0.0.0.0`). 
- With host networking, use `127.0.0.1:11811`. 
- With robot as access point, use `10.42.0.1:11811`
- With robot as client, use ip address displayed on the on-robot display or `/ip` topic

## Robot connected but Topics not visible

- Set `ROS_SUPER_CLIENT=1` in the terminal or under docker environment variables

## Firewall/port issues
- Confirm the server listens on `11811` and the port is open.

## GUI not showing

- Run `xhost +local:root` before `docker compose up`; verify `/tmp/.X11-unix` is mounted and `DISPLAY` is set.

## Verify ROS graph

- Inside `turtlebot4-simulation`, run `ros2 topic list`, check `/map`, `/tf`, and Nav2 nodes (`planner_server`, `controller_server`). 
- Ensure transforms between `map`, `odom`, and `base_link` are present.
- Check the robot namespace

## ROS2 topic list doesnot print the list

- try running the `ros2 daemon stop && ros2 daemon start` command once and wait few seconds