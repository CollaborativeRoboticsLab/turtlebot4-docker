# Doing custom work

Start either the Simulated system or the physical robot

## Workspace via code-server

When the stack is up, the workspace container serves a web browser-based VS Code interface at http://127.0.0.1:8080. Use this for your development work as the environment has been configured to work with turtlebot robots.

- Workspace folder: `/workspace` (mounted from `./turtlebot4-workspace/workspace`)
- Settings/extensions persist to:
    - `./turtlebot4-workspace/code-server/config` → `/root/.config/code-server`
    - `./turtlebot4-workspace/code-server/data` → `/root/.local/share/code-server`

Any files and folders created will be placed under the`/turtlebot4-docker/turtlebot4-workspace/workspace` folder. If you need to bring in work from outside, Copy the content into that folder as well.

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
