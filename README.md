# Requirements
- [`uv`](https://docs.astral.sh/uv/)
- ZED SDK (https://www.stereolabs.com/docs/development/zed-sdk/linux)
- `git lfs` (https://git-lfs.com/)

## Docker Setup
Download preconfigured Docker container snapshot from _____TODO_____, or build you own environment following instructions in the following section.

### Reproducing Environment
1. Setup docker following https://github.com/Robot-VLA/env_setup.git, and enter the container.
2. Install [ZED SDK](https://www.stereolabs.com/developers/release/4.2) v4.2 compatible with CUDA 12, Ubuntu 22.04. by 
  ```bash
  # You might need to accept the terms and conditions on the Stereolabs website first...
  wget -O ZED_SDK_Ubuntu22_cuda12.1_v4.2.5.zstd.run \
  "https://download.stereolabs.com/zedsdk/4.2/cu12/ubuntu22?_gl=1*1x7lpez*_gcl_au*MjAxNDkxODY5MC4xNzU5OTQ5NTE3"
  ```
3. Move to `/tmp/ZED_SDK_Ubuntu22_cuda12.1_v4.2.5.zstd.run`.
4. Install dependencies
  ```bash
  apt-get update # MAKE SURE YOU ARE INSIDE THE CONTAINER
  apt-get install zstd
  ```
5. Install ZED SDK
  ```bash
  chmod +x ZED_SDK_Ubuntu22_cuda12.1_v4.2.5.zstd.run
  ./ZED_SDK_Ubuntu22_cuda12.1_v4.2.5.zstd.run -- silent skip_python
  ```
  Since we are using `uv`, we don't have pip, and ZED SDK only supports pip, we need to do some hacking... 
  ```bash
  vim /usr/local/zed/get_python_api.py
  ```
  Change the `call_list` in `pip_install`:
  ```diff
  - call_list = [sys.executable, "-m", "pip", "install"]
  + call_list = ["uv", "add"]
  ```
  Then run from repo root:
  ```bash
  uv run python /usr/local/zed/get_python_api.py
  ```
  This creates `pyzed-4.2-cp310-cp310-linux_x86_64.whl` in the current directory, which is gitignored.
6. Install other project dependencies
  ```bash
  GIT_LFS_SKIP_SMUDGE=1 uv sync
  ```

# Running Eva

1. 

  
<!-- 
<div align="center">
  <img src="https://github.com/user-attachments/assets/1e36909c-62d8-4fd1-aa3d-333b98d5065e" width="480" />
</div>

Eva is an extendable, versatile, and adaptable robot infrastructure for the Franka Emika Panda, featuring:
- Modular design with atomic components, prioritizing flexibility and customizability.
- Lightweight and simple interfaces via terminal and live camera feed.
- Robust, fault-tolerant components supporting continuous operation.

This project is built on [DROID](https://github.com/droid-dataset/droid). Some components are completely revamped while others are lightly modified, but the hardware setup and data format remain unchanged.

## Installation
The DROID software and hardware setup form the foundation for Eva. Please install them via instructions [here](https://droid-dataset.github.io/droid/).

Afterwards, run the following:
```
git clone https://github.com/willjhliang/eva.git
cd eva
conda create -n eva python=3.10
conda activate eva
pip install -r requirements.txt
./sync_infra.sh
```

## Usage

Following the DROID setup, Eva runs on two machines:
- NUC: Handles low-level control of the Franka Emika with a server built on [Polymetis](https://facebookresearch.github.io/fairo/polymetis/).
- Laptop: Handles high-level logic (policy inference, teleoperation, etc) with a runner that executes user scripts.

We recommend the following tmux setup:
```
+-------------------------+-------------------------+
|                         |                         |
|      Server (NUC)       |     Runner (Laptop)     |
+-------------------------+                         |
|    Scripts (Laptop)     |                         |
|                         |                         |
+-------------------------+-------------------------+
```

### Startup

1. On the NUC, run
```bash
cd eva/eva/robot
./launch_server.sh
```
2. On the laptop, run
```bash
conda activate eva
cd eva/scripts
python start_runner.py
```

### Scripts

After the server and runner are started, you can execute scripts found in `eva/scripts/`. Some of the main functions include:
- `collect_trajectory.py`: Collects teleoperated trajectories saved in `eva/data/`.
- `play_trajectory.py`: Replays a selected trajectory.
- `process_trajectory.py`: Processes the compressed trajectory data into a more usable format.
- `calibrate_camera.py`: Calibrates a camera using the Charuco board.
- `check_calibration.py`: Overlays a gripper annotation on the camera feed.
- `take_pictures.py`: Saves camera pictures to `eva/data/images`.
- `reset_robot.py`: Resets the robot pose to default.

Each script has its own specific arguments as well as a set of general-purpose arguments (found in `eva.py`). Some crucial ones are:
- `--controller`: Sets the control method for the robot, such as teleoperation controllers (e.g., Occulus) or learned policies.
- `--disable_post_process`: Disables online trajectory post-processing, saving space and freeing compute.
- `--record_depth` and `--record_pcd`: Records additional depth and point cloud observations besides the standard RGB.

### Development

Code development should be entirely done on the laptop, and to sync the codebase with the NUC, run `./sync_infra.sh`. Remember to restart the NUC server or runner if code changes affect them.

If you are using Eva and plan to make significant changes, **please work in a copy of this directory** (e.g., `eva_wliang`). -->
