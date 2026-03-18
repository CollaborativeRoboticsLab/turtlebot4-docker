# Doing custom work

Start either the Simulated system or Physical robot and use the workspace (code-server based workspace) provided via webbrowser.

Any files and folders created will be placed under `/turtlebot4-docker/turtlebot4-workspace/workspace` folder. If you need to bring in work from outside,
copy the content into that folder as well.

We recommend creating a ROS 2 colcon workspace inside `/workspace` as shown below

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